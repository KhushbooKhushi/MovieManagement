using System;
using System.Collections.Generic;
using System.Data.Common;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieManagement_Web
{
    public partial class manage_movies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Hit this if block for the first time
            if (!IsPostBack)
            {
                ViewState["actorDetails"] = null;
                List<ActorDetails> list1 = new List<ActorDetails>();
                grActorList.DataSource = list1;
                grActorList.DataBind();
                //Global method to load producer list
                //Pass true if you want to set a default value like "Select Producer" otherwise pass false
                LoadData.ProducerList(ddlProducers, true);
            }
        }

        //Searching actor names
        [System.Web.Services.WebMethod]
        public static List<string> GetActorNameList(string prefixText, int count)
        {
            prefixText = prefixText.ToLower();
            List<string> result = new List<string>();

            DataClasses1DataContext dataContext = new DataClasses1DataContext();


            var list = (from d in dataContext.Actors
                        where d.Name.Contains(prefixText)
                        select new
                        {
                            d.ActorId,
                            d.Name,
                        });

            foreach (var tm in list)
            {
                string item = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(tm.Name, tm.ActorId.ToString());
                result.Add(item);
            }
            return result;
        }


        //visible add new actor panel

        protected void btnAddProducer_Click(object sender, EventArgs e)
        {
            pnl2.Visible = true;
        }

        private void ClearPopUpActor()
        {
            txtActorDobPop2.Text = "";
            txtActorBioPop2.Text = "";
            txtActorNamePop2.Text = "";
            ddlActorGenderPop2.SelectedIndex = 0;
        }

        //add new Producer
        protected void btnProducerAdd_Click(object sender, EventArgs e)
        {
            try
            {
                DataClasses1DataContext dataContext = new DataClasses1DataContext();
                Producer prod = new Producer();

                prod.Name = txtProducerNamePop.Text.Trim();
                prod.DOB = LoadData.CheckDate(txtProducerDOBPop.Text, "Invalid DOB of producer");
                prod.Sex = Convert.ToByte(ddlProducerGenderPop.SelectedValue);
                prod.Bio = txtProducerBIOPop.Text.Trim();

                dataContext.Producers.InsertOnSubmit(prod);
                dataContext.SubmitChanges();

                lblMsgProducer.Text = "New producer added successfully!!";
                lblMsgProducer.ForeColor = System.Drawing.Color.Green;

                txtProducerNamePop.Text = "";
                txtProducerDOBPop.Text = "";
                txtProducerBIOPop.Text = "";
            }
            catch (Exception ex)
            {
                lblMsgProducer.Text = ex.Message;
                lblMsgProducer.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnAddActor_Click1(object sender, EventArgs e)
        {
            pn1.Visible = true;
        }

        //add new actor
        protected void btnAddNewActor_Click(object sender, EventArgs e)
        {
            try
            {
                //dataconnection of the dbml file 
                DataClasses1DataContext dataContext = new DataClasses1DataContext();

                Actor act = new Actor();
                act.Name = txtActorNamePop2.Text.Trim();
                act.Bio = txtActorBioPop2.Text.Trim();
                act.DOB = LoadData.CheckDate(txtActorDobPop2.Text, "Invalid actor dob");
                act.Sex = Convert.ToByte(ddlActorGenderPop2.SelectedValue);

                dataContext.Actors.InsertOnSubmit(act);
                dataContext.SubmitChanges();

                lblPopUpActor.Text = "New Actor added successfully!!";
                lblPopUpActor.ForeColor = System.Drawing.Color.Green;

                ClearPopUpActor();
            }
            catch (Exception ex)
            {
                lblPopUpActor.Text = ex.Message;
                lblPopUpActor.ForeColor = System.Drawing.Color.Red;
            }
        }

        List<ActorDetails> list = new List<ActorDetails>();

        protected void btngridviewadd_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext dataContext = new DataClasses1DataContext();
            try
            {
                ActorDetails actor = new ActorDetails();

                var actors = (from d in dataContext.Actors
                              where d.Name.ToUpper().Trim() == txtActorName.Text.ToUpper().Trim()
                              select d);
                if (actors.Any())
                {
                    actor.ActorId = actors.First().ActorId;
                    actor.ActorName = actors.First().Name;
                    actor.DOB = actors.First().DOB;
                    actor.BIO = actors.First().Bio;
                    actor.Sex = actors.First().Sex;
                }

                if (ViewState["actorDetails"] != null)
                {
                    List<ActorDetails> list2 = ViewState["actorDetails"] as List<ActorDetails>;

                    //If actor already added to this movie so for the next time user can't select same actor/actress
                    foreach (var item in list2)
                    {
                        if (item.ActorId == actor.ActorId)
                            throw new Exception("Actor or Actress already added");
                    }
                }
                if (ViewState["actorDetails"] != null)
                    list = (List<ActorDetails>)ViewState["actorDetails"];
                list.Add(actor);
                ViewState["actorDetails"] = list;

                grActorList.DataSource = list;
                grActorList.DataBind();

                txtActorName.Text = "";
            }
            catch (Exception eX)
            {
                lblMsg.Text = eX.Message;
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        [Serializable]
        class ActorDetails
        {
            public int ActorId { get; set; }
            public string ActorName { get; set; }
            public byte Sex { get; set; }
            public DateTime DOB { get; set; }
            public string BIO { get; set; }
        }

        protected void lbDelete_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                ImageButton lbDelete = (ImageButton)sender;
                int actorId = Convert.ToInt32(lbDelete.CommandArgument);
                if (ViewState["actorDetails"] != null)
                    list = (List<ActorDetails>)ViewState["actorDetails"];
                list.RemoveAll(x => x.ActorId == actorId);
                ViewState["actorDetails"] = list;
                grActorList.DataSource = list;
                grActorList.DataBind();
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message;
            }
        }

        //Add new Movie
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            //when ever we need to insert data in multiple time we need to use transaction if any error occurs data will 
            // not be inserted in any table
            DataClasses1DataContext dataContext = new DataClasses1DataContext();
            DbTransaction transaction = null;
            try
            {
                dataContext.Connection.Open();
                transaction = dataContext.Connection.BeginTransaction();
                dataContext.Transaction = transaction;

                var movieList = (from d in dataContext.Movies
                                 where d.Name.ToUpper().Trim() == txtMovieName.Text.ToUpper().Trim()
                                 select d);
                if (movieList.Any())
                    throw new Exception("Movie already addedd");

                Movie mov = new Movie();

                if (!string.IsNullOrWhiteSpace(txtMovieName.Text))
                    mov.Name = txtMovieName.Text.Trim();
                else
                    throw new Exception("Movie name is required");

                //year of release will in format 2012
                mov.YearOfRelease = txtYearOfRelease.Text.Trim();
                mov.Plot = txtPlot.Text.Trim();

                //Posture of Movie
                if (fuImage.HasFile)
                {
                    Random rad = new Random();
                    rad.Next(0,9999);
                    string fileName = rad.Next() + Path.GetExtension(fuImage.PostedFile.FileName);
                    Stream stream = fuImage.PostedFile.InputStream;
                    System.Drawing.Image img = System.Drawing.Image.FromStream(stream);
                    mov.Poster = fileName;
                    fuImage.SaveAs(Server.MapPath("~/images/" + fileName));
                }

                if (ddlProducers.SelectedValue != "0")
                    mov.ProducerId = Convert.ToInt32(ddlProducers.SelectedValue);
                else
                    throw new Exception("Producer is required.");

                dataContext.Movies.InsertOnSubmit(mov);
                dataContext.SubmitChanges();

                if (ViewState["actorDetails"] != null)
                {
                    List<ActorDetails> list2 = ViewState["actorDetails"] as List<ActorDetails>;

                    //Add Actor and movie relations one by one 
                    foreach (var item in list2)
                    {
                        ActorMovieConnection acm = new ActorMovieConnection();
                        acm.ActorId = item.ActorId;
                        acm.MovieId = mov.MovieId;
                        acm.ConnectionStatus = (byte)ConnectionStatus.Active;

                        dataContext.ActorMovieConnections.InsertOnSubmit(acm);
                        dataContext.SubmitChanges();
                    }
                }

                transaction.Commit();
                lblMsg.Text = "Movie added successfully!!";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                Clear();
                List<ActorDetails> list1 = new List<ActorDetails>();
                grActorList.DataSource = list1;
                grActorList.DataBind();

            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message;
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        private void Clear()
        {
            txtMovieName.Text = "";
            txtPlot.Text = "";
            txtYearOfRelease.Text = "";
            txtActorName.Text = "";
            ddlProducers.SelectedIndex = 0;
        }

        protected void btncloseProducer_Click(object sender, EventArgs e)
        {
            pnl2.Visible = false;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pn1.Visible = false;
        }
    }
}