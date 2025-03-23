using System;
using System.Collections.Generic;

namespace EBookStore.Core.Models;

public partial class Supplier
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string? ContactInfo { get; set; }

    public virtual ICollection<ImportBill> ImportBills { get; set; } = new List<ImportBill>();
}
