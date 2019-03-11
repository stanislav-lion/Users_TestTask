namespace Users.Authentication.Models
{
    using System.ComponentModel.DataAnnotations;

    public class Register
    {
        [Required]
        [StringLength(100)]
        public string UserName { get; set; }

        [Required]
        [StringLength(50)]
        public string FirstName { get; set; }

        [Required]
        [StringLength(100)]
        public string LastName { get; set; }

        [StringLength(30)]
        public string MiddleName { get; set; }

        [Required]
        [StringLength(30, ErrorMessage = "PASSWORD_MIN_LENGTH", MinimumLength = 6)]
        public string Password { get; set; }
    }
}