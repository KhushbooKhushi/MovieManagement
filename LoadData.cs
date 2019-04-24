using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace MovieManagement_Web
{
    public class LoadData
    {
        public static DateTime CheckDate(string date, string errMsg)
        {
            DateTime parsed;
            if (!DateTime.TryParseExact(date, "dd'/'MM'/'yyyy",
                CultureInfo.CurrentCulture, DateTimeStyles.None, out parsed))
                throw new ArgumentException(errMsg);
            return parsed;
        }

        public static void ProducerList(DropDownList ddlProducers,bool showSelect)
        {
            ddlProducers.Items.Clear();
            if (showSelect)
                ddlProducers.Items.Add(new ListItem("Select Producer", "0"));
            DataClasses1DataContext dataContext = new DataClasses1DataContext();
            var roles = (from r1 in dataContext.Producers
                         select r1);
            foreach (var r in roles)
                ddlProducers.Items.Add(new ListItem(r.Name, r.ProducerId.ToString()));
        }

        public static int CheckInt(string n, string errMsg)
        {
            int dc;
            if (!int.TryParse(n, out dc))
                throw new ArgumentException(errMsg);
            return dc;
        }
    }
}