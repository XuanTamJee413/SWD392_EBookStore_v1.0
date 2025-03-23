using System;
using System.Collections.Generic;

namespace EBookStore.Core.Models;

public partial class ImportBillDetail
{
    public int Id { get; set; }

    public int ImportBillId { get; set; }

    public int BookId { get; set; }

    public int Quantity { get; set; }

    public decimal CostPrice { get; set; }

    public virtual Book Book { get; set; } = null!;

    public virtual ImportBill ImportBill { get; set; } = null!;
}
