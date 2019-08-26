using System;
using System.Collections.Generic;
using System.Text;

namespace CCMS.Core.Services.Common
{
    class CommonFunctions
    {
        public static DateTime ConvertToNzTimeZone(DateTime utcdt)
        {
            return TimeZoneInfo.ConvertTimeFromUtc(utcdt, TimeZoneInfo.FindSystemTimeZoneById("New Zealand Standard Time"));
        }

    }
}
