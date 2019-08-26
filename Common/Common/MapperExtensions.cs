using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCMS.Common
{
    public static class MapperExtensions
    {
        public static IEnumerable<TOutput> MapAll<TInput, TOutput>(this IMapper<TInput, TOutput> mapper,
            IEnumerable<TInput> input)
        {
            return input.Select(x => mapper.Map(x));
        }
    }
}
