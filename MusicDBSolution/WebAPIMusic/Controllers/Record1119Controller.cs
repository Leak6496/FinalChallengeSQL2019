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
    public class Record1119Controller : ApiController
    {
        private DADICTWEB425Entities1 db = new DADICTWEB425Entities1();

        // GET: api/Record1119
        public IQueryable<Record1119> GetRecord1119()
        {
            return db.Record1119;
        }

        // GET: api/Record1119/5
        [ResponseType(typeof(Record1119))]
        public async Task<IHttpActionResult> GetRecord1119(string id)
        {
            Record1119 record1119 = await db.Record1119.FindAsync(id);
            if (record1119 == null)
            {
                return NotFound();
            }

            return Ok(record1119);
        }

        // PUT: api/Record1119/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutRecord1119(string id, Record1119 record1119)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != record1119.RecordID)
            {
                return BadRequest();
            }

            db.Entry(record1119).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!Record1119Exists(id))
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

        // POST: api/Record1119
        [ResponseType(typeof(Record1119))]
        public async Task<IHttpActionResult> PostRecord1119(Record1119 record1119)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Record1119.Add(record1119);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (Record1119Exists(record1119.RecordID))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = record1119.RecordID }, record1119);
        }

        // DELETE: api/Record1119/5
        [ResponseType(typeof(Record1119))]
        public async Task<IHttpActionResult> DeleteRecord1119(string id)
        {
            Record1119 record1119 = await db.Record1119.FindAsync(id);
            if (record1119 == null)
            {
                return NotFound();
            }

            db.Record1119.Remove(record1119);
            await db.SaveChangesAsync();

            return Ok(record1119);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool Record1119Exists(string id)
        {
            return db.Record1119.Count(e => e.RecordID == id) > 0;
        }
    }
}