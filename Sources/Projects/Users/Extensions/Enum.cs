namespace Users.Extensions
{
    using System;
    using System.ComponentModel;
    using System.Globalization;
    using System.Linq;
    using System.Reflection;

    public static class Enum
    {
        public static string GetDescription(this IConvertible typeEnum)
        {
            Type type = typeEnum.GetType();
            Array values = System.Enum.GetValues(type);

            foreach (int value in values)
            {
                if (value == typeEnum.ToInt32(CultureInfo.InvariantCulture))
                {
                    MemberInfo[] memberInfo = type.GetMember(type.GetEnumName(value));

                    DescriptionAttribute descriptionAttribute = memberInfo[0]
                        .GetCustomAttributes(typeof(DescriptionAttribute), false)
                        .FirstOrDefault() as DescriptionAttribute;

                    if (descriptionAttribute != null)
                    {
                        return descriptionAttribute.Description;
                    }
                }
            }

            return null;
        }
    }
}