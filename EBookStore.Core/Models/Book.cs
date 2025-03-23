using System;
using System.Collections.Generic;

namespace EBookStore.Core.Models;

public partial class Book
{
    public int Id { get; set; }

    public string Title { get; set; } = null!;

    public string Author { get; set; } = null!;

    public int CategoryId { get; set; }

    public string? Description { get; set; }

    public string Isbn { get; set; } = null!;

    public int PublishedYear { get; set; }

    public string? ImageUrl { get; set; }

    public virtual Category Category { get; set; } = null!;

    public virtual ICollection<Discount> Discounts { get; set; } = new List<Discount>();

    public virtual ICollection<ImportBillDetail> ImportBillDetails { get; set; } = new List<ImportBillDetail>();

    public virtual ICollection<Inventory> Inventories { get; set; } = new List<Inventory>();

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();
}
