using System;
using System.Collections.Generic;

namespace EBookStore.Core.Models;

public partial class Feedback
{
    public int Id { get; set; }

    public int OrderId { get; set; }

    public int? Rating { get; set; }

    public string? Comment { get; set; }

    public virtual Order Order { get; set; } = null!;
}
