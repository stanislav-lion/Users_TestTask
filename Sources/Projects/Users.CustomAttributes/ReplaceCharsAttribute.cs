﻿namespace Users.CustomAttributes
{
    using System;

    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Method, Inherited = true)]
    public class ReplaceCharsAttribute : Attribute
    {
        private char _oldValue;
        private char _newValue;

        private const char DefaultOldValue = '_';
        private const char DefaultNewValue = ' ';

        public ReplaceCharsAttribute()
        {
            _oldValue = DefaultOldValue;
            _newValue = DefaultNewValue;
        }

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