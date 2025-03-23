using System;
using System.Collections.Generic;

namespace EBookStore.Core.Models;

public partial class User
{
    public int Id { get; set; }

    public string FullName { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string PhoneNumber { get; set; } = null!;

    public string? Address { get; set; }

    public string Password { get; set; } = null!;

    public int RoleId { get; set; }

    public virtual ICollection<ImportBill> ImportBills { get; set; } = new List<ImportBill>();

    public virtual ICollection<News> News { get; set; } = new List<News>();

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual UserRole Role { get; set; } = null!;
}
