using System;

namespace CCMS.Common.Services.CommonServices
{
    class CommonFunctions
    {
        public static DateTime ConvertToNzTimeZone(DateTime utcdt)
        {
            return TimeZoneInfo.ConvertTimeFromUtc(utcdt, TimeZoneInfo.FindSystemTimeZoneById("New Zealand Standard Time"));
        }

    }
}
