using System;
using System.Collections.Generic;

namespace EBookStore.Core.Models;

public partial class Order
{
    public int Id { get; set; }

    public int CustomerId { get; set; }

    public DateTime? OrderDate { get; set; }

    public decimal TotalPrice { get; set; }

    public int StatusId { get; set; }

    public virtual User Customer { get; set; } = null!;

    public virtual ICollection<Feedback> Feedbacks { get; set; } = new List<Feedback>();

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual OrderStatus Status { get; set; } = null!;
}
