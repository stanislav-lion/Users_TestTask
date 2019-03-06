namespace Users.DataAccess.DataModel.Attributes
{
    using System;
    using System.ComponentModel.DataAnnotations;

    /// <inheritdoc />
    /// <summary> 
    ///     Validates if the DateTime object has UTC date kind.
    /// </summary>
    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field)]
    internal class DateTimeUtcKindAttribute : ValidationAttribute
    {
        /// <inheritdoc />
        public override bool IsValid(object value)
        {
            if (!(value is DateTime))
            {
                return true;
            }

            var dateTime = (DateTime) value;

            return dateTime.Kind == DateTimeKind.Utc;
        }

        /// <inheritdoc />
        public override string FormatErrorMessage(string name)
        {
            return string.Format(ValidationStrings.DateTimeFieldValueMustHaveUtcKind, name);
        }
    }
}