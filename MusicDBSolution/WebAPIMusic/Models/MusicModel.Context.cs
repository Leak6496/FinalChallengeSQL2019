﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebAPIMusic.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class DADICTWEB425Entities1 : DbContext
    {
        public DADICTWEB425Entities1()
            : base("name=DADICTWEB425Entities1")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Customer1119> Customer1119 { get; set; }
        public virtual DbSet<Interest1119> Interest1119 { get; set; }
        public virtual DbSet<Record1119> Record1119 { get; set; }
        public virtual DbSet<Sale1119> Sale1119 { get; set; }
    }
}