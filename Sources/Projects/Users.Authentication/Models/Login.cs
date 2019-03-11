namespace Users.Authentication.Models
{
    using System.ComponentModel.DataAnnotations;

    public class Login
    {
        [Required]
        [StringLength(100)]
        public string UserName { get; set; }

        [Required]
        [StringLength(30)]
        public string Password { get; set; }
    }
}