//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace awesome_exam.Database
{
    using System;
    using System.Collections.Generic;
    
    public partial class HistoryCost
    {
        public int ID { get; set; }
        public string Title { get; set; }
        public decimal OldCost { get; set; }
        public decimal NewCost { get; set; }
        public System.DateTime ChangedAt { get; set; }
    }
}
