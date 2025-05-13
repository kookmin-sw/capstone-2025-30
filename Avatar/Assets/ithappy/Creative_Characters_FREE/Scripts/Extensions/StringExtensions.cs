using System;

namespace CharacterCustomizationTool.Extensions
{
    public static class StringExtensions
    {
        public static string ToCapital(this string input)
        {
            return input switch
            {
                null => throw new ArgumentNullException(nameof(input)),
                "" => throw new ArgumentException($"{nameof(input)} cannot be empty", nameof(input)),
                _ => input[0].ToString().ToUpper() + input[1..]
            };
        }
    }
}