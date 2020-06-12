using System;
using System.Collections.Generic;
using System.Text;

namespace Services.Common
{
    class CommonFunctions
    {
        public static DateTime ConvertToNzTimeZone(DateTime utcdt)
        {
            return TimeZoneInfo.ConvertTimeFromUtc(utcdt, TimeZoneInfo.FindSystemTimeZoneById("New Zealand Standard Time"));
        }

    }
}
