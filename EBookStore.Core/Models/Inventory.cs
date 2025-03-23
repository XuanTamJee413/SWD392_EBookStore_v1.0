using System;
using System.Collections.Generic;

namespace EBookStore.Core.Models;

public partial class Inventory
{
    public int Id { get; set; }

    public int BookId { get; set; }

    public int Quantity { get; set; }

    public decimal SalePrice { get; set; }

    public virtual Book Book { get; set; } = null!;
}
