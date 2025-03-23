using System;
using System.Collections.Generic;

namespace EBookStore.Core.Models;

public partial class News
{
    public int Id { get; set; }

    public string Title { get; set; } = null!;

    public string Content { get; set; } = null!;

    public DateTime? PublishedAt { get; set; }

    public string Status { get; set; } = null!;

    public int UserId { get; set; }

    public virtual User User { get; set; } = null!;
}
