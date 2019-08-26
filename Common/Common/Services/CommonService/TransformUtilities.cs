using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;

namespace CCMS.Common.Services.TransformUtilities
{
   public static class TextTransform
    {

        /// <summary>
        /// 
        /// </summary>
        /// <param name="text"></param>
        /// <returns></returns>
        public static string RemoveMacrons(string text)
        {
            var normalizedString = text.Normalize(NormalizationForm.FormD);
            var stringBuilder = new StringBuilder();

            foreach (var c in normalizedString)
            {
                var unicodeCategory = CharUnicodeInfo.GetUnicodeCategory(c);
                if (unicodeCategory != UnicodeCategory.NonSpacingMark)
                {
                    stringBuilder.Append(c);
                }
            }

            return stringBuilder.ToString().Normalize(NormalizationForm.FormC);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="text"></param>
        /// <param name="allowedChars"></param>
        /// <returns></returns>
        public static string RemoveNotAllowedChars(string text, string allowedChars)
        {
            string pattern = @"[^" + Regex.Escape(allowedChars) + "]";

            return Regex.Replace(text, pattern, "");
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="text"></param>
        /// <param name="replacedChars"></param>
        /// <returns></returns>
        public static string ReplaceCharsWithSpace(string text, string replacedChars)
        {
            string pattern = @"[" + Regex.Escape(replacedChars) + "]";

            return Regex.Replace(text, pattern, " ");
        }

    }
}

