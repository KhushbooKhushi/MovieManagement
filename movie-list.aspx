<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="movie-list.aspx.cs" Inherits="MovieManagement_Web.movie_list" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .loading {
            background-image: url(images/loading_ajax.gif);
            background-size: 20px 20px;
            background-position: right;
            background-repeat: no-repeat;
        }

        .completionList {
            margin: 0px;
            padding: 2px;
            height: auto;
            max-height: 150px;
            overflow: auto;
            background-color: #f0f0f0;
            z-index: 10000000;
            position: absolute;
            margin: 0px !important;
            z-index: 99999 !important;
        }

        .listItem {
            color: #1C1C1C;
            cursor: pointer;
            border-radius: 5px;
            padding: 3px;
        }

            .listItem:hover {
                cursor: pointer;
            }

        .itemHighlighted {
            border-radius: 2px;
            padding: 3px;
            background: #dbe6e2;
            cursor: pointer;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="sc" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="hdnOrderItemId" runat="server" />
    <section class="content-header">
        <div class="header-icon">
            <i class="pe-7s-box1"></i>
        </div>
        <div class="header-title">
            <h1>Movie List</h1>
            <small>Movie List</small>
        </div>
    </section>
    <!-- Main content -->
    <section class="content">
        <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
                <asp:UpdateProgress ID="upp1" runat="server" AssociatedUpdatePanelID="up1">
                    <ProgressTemplate>
                        <div class="divElement"></div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="panel panel-bd">
                            <div class="panel-heading">
                                <div class="panel-title">
                                    <h4>Movie List</h4>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div style="text-align: center">
                                    <strong>
                                        <asp:Label ID="lblMsg" runat="server"></asp:Label>
                                    </strong>
                                </div>
                            </div>
                            <asp:Panel ID="pnlDetails" runat="server">
                                <fieldset class="panel-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Serial No</th>
                                                    <th>View Actors</th>
                                                    <th>Movie Name</th>
                                                    <th>Release Year</th>
                                                    <th>Plot</th>

                                                    <th>Producer</th>
                                                    <th>Poster</th>
                                                    <th>Edit</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rptMoies" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>
                                                                <label><%# Container.ItemIndex +1 %> </label>
                                                            </td>
                                                            <td>
                                                                <asp:Button Text="View Actors" CssClass="btn-danger btn" ID="btnShowActors" runat="server" OnClick="btnShowActors_Click" CommandArgument='<%#Eval("MovieId") %>' />
                                                            </td>
                                                            <td><%#Eval("MovieName") %> </td>
                                                            <td><%#Eval("YearOfRelease") %> </td>
                                                            <td><%#Eval("Plot") %> </td>
                                                            <td><%#Eval("ProducerName") %> </td>
                                                            <td>
                                                                <asp:ImageButton ID="imgImage" ImageUrl='<%# string.Format("~/images/{0}",Eval("Poster"))%>' Width="50" Height="50" runat="server" /></td>
                                                            <td>
                                                                <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-success" Text="Edit" /></td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
                                    </div>
                                </fieldset>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
                <asp:Button ID="btn" runat="server" Style="display: none" />
                <asp:HiddenField ID="hdnId" runat="server" />
                <asp:Button ID="Button1" runat="server" Style="display: none" />
                <ajaxa:ModalPopupExtender ID="mpe1" PopupControlID="pn1" CancelControlID="btnClose" PopupDragHandleControlID="drg" BackgroundCssClass="backCss" TargetControlID="btn" runat="server"></ajaxa:ModalPopupExtender>
                <asp:Panel ID="pn1" runat="server" Width="800">
                    <div class="panel panel-bd" id="drg">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <h4>Actors List</h4>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="col-sm-12" style="text-align: center">
                                <asp:Label ID="lblMsg2" runat="server" Style="font-weight: 700"></asp:Label>
                            </div>
                            <fieldset class="panel-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>Actor Name</th>
                                                <th>Sex</th>
                                                <th>BIO</th>
                                                <th>DOB</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater ID="rptActors" runat="server">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdnActorId" Value='<%#Eval("ActorId") %>' runat="server" />
                                                    <tr>
                                                        <td><%#Eval("Name") %> </td>
                                                        <td>
                                                            <asp:Label ID="lblSex" runat="server" Text='<%# (MovieManagement_Web.Gender)Convert.ToInt32(Eval("Sex")) %>'></asp:Label></td>
                                                        <td><%#Eval("Bio") %> </td>
                                                        <td><%#Eval("DOB") %> </td>

                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                    </table>
                                </div>
                            </fieldset>
                            <div class="col-sm-12">
                                <div class="btn-group col-sm-12" style="text-align: center">
                                    <div class="col-lg-4">
                                        <asp:Button ID="btnClose" runat="server" class="btn btn-warning" Text="Close" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>


                <asp:Button ID="btn2" runat="server" Style="display: none" />
                <asp:HiddenField ID="HiddenField1" runat="server" />
                <asp:Button ID="Button3" runat="server" Style="display: none" />
                <ajaxa:ModalPopupExtender ID="mpeEdit" PopupControlID="pn2" CancelControlID="btnClose" PopupDragHandleControlID="drg2" BackgroundCssClass="backCss" TargetControlID="btn2" runat="server"></ajaxa:ModalPopupExtender>
                <asp:Panel ID="pn2" runat="server" Width="800">
                    <div class="panel panel-bd" id="drg2">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <h4>Actors List</h4>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="col-sm-12" style="text-align: center">
                                <asp:Label ID="Label1" runat="server" Style="font-weight: 700"></asp:Label>
                            </div>
                            <div class="col-sm-12 form-group">
                                <div class="col-sm-6">
                                    <div class="col-sm-4">
                                        <label>Movie Name</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtMovieName" placeholder="Movie Name" runat="server" CssClass="form-control"></asp:TextBox>
                                        <div>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtMovieName" Display="Dynamic" ValidationGroup="g3" ForeColor="Red" ErrorMessage="Movie Name is required."></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="col-sm-4">
                                        <label>Year Of Release</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtYearOfRelease" placeholder="Year Of Release" MaxLength="4" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 form-group">
                                <div class="col-sm-6">
                                    <div class="col-sm-4">
                                        <label>Plot</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:TextBox ID="txtPlot" placeholder="Plot" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="col-sm-4">
                                        <label>Poster</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 form-group">
                                <div class="col-sm-6">
                                    <div class="col-sm-4">
                                        <label>Producer Name</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <asp:DropDownList ID="ddlProducers" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ForeColor="Red" ValidationGroup="g3" InitialValue="0" ErrorMessage="Producer name is required" ControlToValidate="ddlProducers"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                            <fieldset class="panel-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>Actor Name</th>
                                                <th>Sex</th>
                                                <th>BIO</th>
                                                <th>DOB</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater ID="Repeater1" runat="server">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdnActorId" Value='<%#Eval("ActorId") %>' runat="server" />
                                                    <tr>
                                                        <td><%#Eval("Name") %> </td>
                                                        <td>
                                                            <asp:Label ID="lblSex" runat="server" Text='<%# (MovieManagement_Web.Gender)Convert.ToInt32(Eval("Sex")) %>'></asp:Label></td>
                                                        <td><%#Eval("Bio") %> </td>
                                                        <td><%#Eval("DOB") %> </td>

                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                    </table>
                                </div>
                            </fieldset>
                            <div class="col-sm-12">
                                <div class="btn-group col-sm-12" style="text-align: center">
                                    <div class="col-lg-4">
                                        <asp:Button ID="Button4" runat="server" class="btn btn-warning" Text="Close" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </section>
    <script type="text/javascript">
        function ClientItemSelected(sender, e) {
            $get("<%=hdnOrderId.ClientID %>").value = e.get_value();
        }

        function OnClientPopulating(sender, e) {
            sender._element.className = "form-control loading";
        }
        function OnClientCompleted(sender, e) {
            sender._element.className = "form-control";
        }
        function makeDefault() {

        }
    </script>
</asp:Content>
