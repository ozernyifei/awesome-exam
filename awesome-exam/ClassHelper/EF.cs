using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace awesome_exam.ClassHelper
{
    internal class EF
    {
        public static Database.Entities Context { get; } = new Database.Entities();
    }
}
