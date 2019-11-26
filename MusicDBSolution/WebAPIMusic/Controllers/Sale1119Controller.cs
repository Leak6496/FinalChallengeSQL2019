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
    public class Sale1119Controller : ApiController
    {
        private DADICTWEB425Entities1 db = new DADICTWEB425Entities1();

        // GET: api/Sale1119
        public IQueryable<Sale1119> GetSale1119()
        {
            return db.Sale1119;
        }

        // GET: api/Sale1119/5
        [ResponseType(typeof(Sale1119))]
        public async Task<IHttpActionResult> GetSale1119(int id)
        {
            Sale1119 sale1119 = await db.Sale1119.FindAsync(id);
            if (sale1119 == null)
            {
                return NotFound();
            }

            return Ok(sale1119);
        }

        // PUT: api/Sale1119/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutSale1119(int id, Sale1119 sale1119)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != sale1119.CustNo)
            {
                return BadRequest();
            }

            db.Entry(sale1119).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!Sale1119Exists(id))
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

        // POST: api/Sale1119
        [ResponseType(typeof(Sale1119))]
        public async Task<IHttpActionResult> PostSale1119(Sale1119 sale1119)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Sale1119.Add(sale1119);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (Sale1119Exists(sale1119.CustNo))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = sale1119.CustNo }, sale1119);
        }

        // DELETE: api/Sale1119/5
        [ResponseType(typeof(Sale1119))]
        public async Task<IHttpActionResult> DeleteSale1119(int id)
        {
            Sale1119 sale1119 = await db.Sale1119.FindAsync(id);
            if (sale1119 == null)
            {
                return NotFound();
            }

            db.Sale1119.Remove(sale1119);
            await db.SaveChangesAsync();

            return Ok(sale1119);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool Sale1119Exists(int id)
        {
            return db.Sale1119.Count(e => e.CustNo == id) > 0;
        }
    }
}