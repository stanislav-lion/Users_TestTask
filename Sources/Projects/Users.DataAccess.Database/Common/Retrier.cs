namespace Users.DataAccess.Database.Common
{
    using System;
    using System.Collections.Generic;
    using System.Runtime.ExceptionServices;
    using System.Threading;

    /// <summary>
    ///     Helper class that performs the action with retries.
    /// </summary>
    public static class Retrier
    {
        /// <summary>
        ///     Performs the action with retries.
        /// </summary>
        /// <param name="action">The action to perform.</param>
        /// <param name="retriesNumber">The retries number.</param>
        /// <param name="sleepBetweenRetriesMilliSeconds">The time in milliseconds between retries.</param>
        /// <param name="isErrorRetriable">The function that returns whether an occurred exception is retriable.</param>
        /// <exception cref="ArgumentNullException">Thrown if action or isErrorRetriable is null.</exception>
        /// <exception cref="ArgumentException">Thrown if retriesNumber or sleepBetweenRetriesMilliSeconds is negative.</exception>
        /// <exception cref="AggregateException">Thrown when performing the action leads to multiple exceptions.</exception>
        public static void InvokeAction(
            Action action,
            int retriesNumber,
            int sleepBetweenRetriesMilliSeconds,
            Func<Exception, bool> isErrorRetriable)
        {
            if (action == null)
            {
                throw new ArgumentNullException(nameof(action));
            }

            if (retriesNumber < 0)
            {
                throw new ArgumentException(string.Format(CommonStrings.ValueCannotBeNegative, "retriesNumber"));
            }

            if (sleepBetweenRetriesMilliSeconds < 0)
            {
                throw new ArgumentException(
                    string.Format(CommonStrings.ValueCannotBeNegative, "sleepBetweenRetriesMilliSeconds"));
            }

            if (isErrorRetriable == null)
            {
                throw new ArgumentNullException(nameof(isErrorRetriable));
            }

            var exceptions = new List<Exception>();
            var retry = 0;
            do
            {
                try
                {
                    action.Invoke();
                    return;
                }
                catch (Exception exception)
                {
                    if (!isErrorRetriable(exception))
                    {
                        if (exceptions.Count <= 0)
                        {
                            ExceptionDispatchInfo.Capture(exception).Throw();
                        }

                        exceptions.Add(exception);
                        throw new AggregateException(exceptions);
                    }

                    exceptions.Add(exception);

                    retry++;
                    Thread.Sleep(sleepBetweenRetriesMilliSeconds);
                }
            } while (retry <= retriesNumber);
        }
    }
}