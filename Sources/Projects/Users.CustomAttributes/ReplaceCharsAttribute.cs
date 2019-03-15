namespace Users.CustomAttributes
{
    using System;

    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Method)]
    public class ReplaceCharsAttribute : Attribute
    {
        private char _oldValue;
        private char _newValue;

        public ReplaceCharsAttribute(
            char oldValue,
            char newValue)
        {
            _oldValue = oldValue;
            _newValue = newValue;
        }

        public virtual char OldValue
        {
            get { return _oldValue; }
            set { _newValue = value; }
        }

        public virtual char NewValue
        {
            get { return _newValue; }
            set { _newValue = value; }
        }
    }
}