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
    public class Interest1119Controller : ApiController
    {
        private DADICTWEB425Entities1 db = new DADICTWEB425Entities1();

        // GET: api/Interest1119
        public IQueryable<Interest1119> GetInterest1119()
        {
            return db.Interest1119;
        }

        // GET: api/Interest1119/5
        [ResponseType(typeof(Interest1119))]
        public async Task<IHttpActionResult> GetInterest1119(string id)
        {
            Interest1119 interest1119 = await db.Interest1119.FindAsync(id);
            if (interest1119 == null)
            {
                return NotFound();
            }

            return Ok(interest1119);
        }

        // PUT: api/Interest1119/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutInterest1119(string id, Interest1119 interest1119)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != interest1119.InterestCode)
            {
                return BadRequest();
            }

            db.Entry(interest1119).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!Interest1119Exists(id))
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

        // POST: api/Interest1119
        [ResponseType(typeof(Interest1119))]
        public async Task<IHttpActionResult> PostInterest1119(Interest1119 interest1119)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Interest1119.Add(interest1119);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (Interest1119Exists(interest1119.InterestCode))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = interest1119.InterestCode }, interest1119);
        }

        // DELETE: api/Interest1119/5
        [ResponseType(typeof(Interest1119))]
        public async Task<IHttpActionResult> DeleteInterest1119(string id)
        {
            Interest1119 interest1119 = await db.Interest1119.FindAsync(id);
            if (interest1119 == null)
            {
                return NotFound();
            }

            db.Interest1119.Remove(interest1119);
            await db.SaveChangesAsync();

            return Ok(interest1119);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool Interest1119Exists(string id)
        {
            return db.Interest1119.Count(e => e.InterestCode == id) > 0;
        }
    }
}