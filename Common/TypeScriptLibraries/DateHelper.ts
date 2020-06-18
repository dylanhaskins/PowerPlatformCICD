/**
 * Returns a date value formatted to 2 digits.
 * @param date Date to be formatted.
 */
const GetDate = function (date: Date): string {
    if (!date || !IsDate(date)) {
        return null;
    }

    const dateStr: string = date.getDate().toString();
    return dateStr.length > 1 ? dateStr : '0' + dateStr;
}

/**
 * Returns a month value formatted to 2 digits.
 * @param date Date to be formatted.
 */
const GetMonth = function (date: Date): string {
    if (!date || !IsDate(date)) {
        return null;
    }

    const monthStr: string = (date.getMonth() + 1).toString();
    return monthStr.length > 1 ? monthStr : '0' + monthStr;
}

/**
 * Returns a year value.
 * @param date Date to be formatted.
 */
const GetYear = function (date: Date): string {
    if (!date || !IsDate(date)) {
        return null;
    }

    const yearStr: string = (date.getFullYear()).toString();
    return yearStr;
}

/**
 * Returns an hour value formatted to 2 digits.
 * @param date Date to be formatted.
 */
const GetHours = function (date: Date): string {
    if (!date || !IsDate(date)) {
        return null;
    }

    const hourStr: string = (date.getHours() % 12).toString();

    if (hourStr == '0') return '12';

    return hourStr.length > 1 ? hourStr : '0' + hourStr;
}

/**
 * Returns a minute value formatted to 2 digits.
 * @param date Date to be formatted.
 */
const GetMinutes = function (date: Date): string {
    if (!date || !IsDate(date)) {
        return null;
    }

    const minuteStr: string = date.getMinutes().toString();
    return minuteStr.length > 1 ? minuteStr : '0' + minuteStr;
}

/**
 * Returns am/pm depending on the specified time value.
 * @param date Date to be formatted.
 */
const GetAmPm = function (date: Date): string {
    if (!date || !IsDate(date)) {
        return null;
    }

    const hours: number = date.getHours();
    return hours > 11 ? 'pm' : 'am';
}

/**
 * Returns a date value formatted as dd/mm/yyyy.
 * @param date Date to be formatted.
 */
const GetShortDate = function (date: Date) {
    if (!date || !IsDate(date)) {
        console.error('GetShortDate(): Provided argument is null')
        return null;
    }

    const day = GetDate(date),
        month = GetMonth(date),
        year = GetYear(date);

    if (!(day && month && year)) {
        console.error('GetShortDate(): day, month, or year was unable to be determined.');
        return null;
    }

    return `${day}/${month}/${year}`;
}

/**
 * Returns the time component of a specified date.
 * Formatted as hh:mm am/pm.
 * @param date Date to be formatted.
 */
const Get12HrTime = function (date: Date) {
    if (!date || !IsDate(date)) {
        console.error('Get12HrTime(): Provided argument is null')
        return null;
    }

    const hours = GetHours(date),
        minutes = GetMinutes(date),
        amPm = GetAmPm(date);

    if (!(hours && minutes && amPm)) { // If any are null
        console.error('Get12HrTime(): hours, minutes, or am/pm was unable to be determined.');
        return null;
    }

    return `${hours}:${minutes} ${amPm}`
}

const IsDate = function (date: Date) {
    return date && Object.prototype.toString.call(date) === "[object Date]"
}

export {
    GetDate,
    GetMonth,
    GetYear,
    GetHours,
    GetMinutes,
    GetAmPm,
    GetShortDate,
    Get12HrTime
}