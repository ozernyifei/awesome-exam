using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace awesome_exam.helper
{
    internal class EF
    {
        public static DB.Entities Context { get; } = new DB.Entities();
    }
}
