using System;
using System.Collections.Generic;

namespace EBookStore.Core.Models;

public partial class ImportBill
{
    public int Id { get; set; }

    public int SupplierId { get; set; }

    public int StaffId { get; set; }

    public virtual ICollection<ImportBillDetail> ImportBillDetails { get; set; } = new List<ImportBillDetail>();

    public virtual User Staff { get; set; } = null!;

    public virtual Supplier Supplier { get; set; } = null!;
}
