using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using WebAPIMusic.Models;

namespace WebAPIMusic.Controllers
{
    public class Customer1119Controller : ApiController
    {
        private DADICTWEB425Entities1 db = new DADICTWEB425Entities1();

        // GET: api/Customer1119
        public IQueryable<Customer1119> GetCustomer1119()
        {
            return db.Customer1119;
        }

        // GET: api/Customer1119/5
        [ResponseType(typeof(Customer1119))]
        public async Task<IHttpActionResult> GetCustomer1119(int id)
        {
            Customer1119 customer1119 = await db.Customer1119.FindAsync(id);
            if (customer1119 == null)
            {
                return NotFound();
            }

            return Ok(customer1119);
        }

        // PUT: api/Customer1119/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutCustomer1119(int id, Customer1119 customer1119)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != customer1119.CustNo)
            {
                return BadRequest();
            }

            db.Entry(customer1119).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!Customer1119Exists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Customer1119
        [ResponseType(typeof(Customer1119))]
        public async Task<IHttpActionResult> PostCustomer1119(Customer1119 customer1119)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Customer1119.Add(customer1119);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (Customer1119Exists(customer1119.CustNo))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = customer1119.CustNo }, customer1119);
        }

        // DELETE: api/Customer1119/5
        [ResponseType(typeof(Customer1119))]
        public async Task<IHttpActionResult> DeleteCustomer1119(int id)
        {
            Customer1119 customer1119 = await db.Customer1119.FindAsync(id);
            if (customer1119 == null)
            {
                return NotFound();
            }

            db.Customer1119.Remove(customer1119);
            await db.SaveChangesAsync();

            return Ok(customer1119);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool Customer1119Exists(int id)
        {
            return db.Customer1119.Count(e => e.CustNo == id) > 0;
        }
    }
}