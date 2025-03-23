using System;
using System.Collections.Generic;

namespace EBookStore.Core.Models;

public partial class Discount
{
    public int Id { get; set; }

    public int BookId { get; set; }

    public int DiscountPercentage { get; set; }

    public DateOnly StartDate { get; set; }

    public DateOnly EndDate { get; set; }

    public virtual Book Book { get; set; } = null!;
}
