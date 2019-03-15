namespace Users.CustomAttributes
{
    using System;

    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Method)]
    public class ReplaceStringsAttribute : Attribute
    {
        private string _oldValue;
        private string _newValue;

        private const string DefaultOldValue = "_";
        private const string DefaultNewValue = " ";

        public ReplaceStringsAttribute()
        {
            _oldValue = DefaultOldValue;
            _newValue = DefaultNewValue;
        }

        public ReplaceStringsAttribute(
            string oldValue,
            string newValue)
        {
            _oldValue = oldValue;
            _newValue = newValue;
        }

        public virtual string OldValue
        {
            get { return _oldValue; }
            set { _newValue = value; }
        }

        public virtual string NewValue
        {
            get { return _newValue; }
            set { _newValue = value; }
        }
    }
}