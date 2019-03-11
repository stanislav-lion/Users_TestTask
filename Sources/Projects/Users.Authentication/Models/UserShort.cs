namespace Users.Authentication.Models
{
    using System.ComponentModel.DataAnnotations;

    public class UserShort
    {
        [Required]
        public int UserId { get; set; }

        [Required]
        public string UserName { get; set; }

        [Required]
        public string FirstName { get; set; }

        [Required]
        public string LastName { get; set; }

        public string Token { get; set; }
    }
}