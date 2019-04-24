using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MovieManagement_Web
{
    public partial class movie_list : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMoviesList();
            }
        }

        private void LoadMoviesList()
        {
            try
            {
                DataClasses1DataContext dataContext = new DataClasses1DataContext();
                var list = (from d in dataContext.Movies
                            join prod in dataContext.Producers
                            on d.ProducerId equals prod.ProducerId
                            select new
                            {
                                MovieName = d.Name,
                                ProducerName = prod.Name,
                                d.MovieId,
                                d.Plot,
                                d.YearOfRelease,
                                d.Poster,
                            });

                rptMoies.DataSource = list;
                rptMoies.DataBind();
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message;
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnShowActors_Click(object sender, EventArgs e)
        {
            try
            {
                Button btn = sender as Button;
                int movieId = Convert.ToInt32(btn.CommandArgument);
                DataClasses1DataContext dataContext = new DataClasses1DataContext();
                var list = (from d in dataContext.ActorMovieConnections
                            join act in dataContext.Actors
                                on d.ActorId equals act.ActorId
                            where d.MovieId == movieId
                            select new
                            {
                                act.Name,
                                act.ActorId,
                                act.Sex,
                                act.Bio,
                                act.DOB,
                            }).Distinct();
                rptActors.DataSource = list;
                rptActors.DataBind();
                mpe1.Show();
            }
            catch (Exception ex)
            {
            }
        }

    }
}