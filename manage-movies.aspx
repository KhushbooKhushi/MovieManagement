<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="manage-movies.aspx.cs" Inherits="MovieManagement_Web.manage_movies" %>
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

        .divElement {
            position: fixed;
            top: 50%;
            left: 50%;
            margin-top: -50px;
            margin-left: -50px;
            width: 100px;
            height: 100px;
            background-image: url('images/progress.gif');
            background-size: 100px 100px;
            z-index: 34249320342;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="sc" runat="server"></asp:ScriptManager>
    <section class="content-header">
        <div class="header-icon">
            <i class="pe-7s-box1"></i>
        </div>
        <div class="header-title">
            <h1>Manage Movies</h1>
            <small>Manage Movies</small>
        </div>
    </section>
    <!-- Main content -->
    <section class="content">
        <asp:HiddenField ID="hdnMovieId" runat="server" />
        <asp:HiddenField ID="hdnProducerId" runat="server" />
        <asp:HiddenField ID="hdnActorId" runat="server" />
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
                                    <div class="panel-title">
                                        <h4>Manage Movie
                                        <span>
                                            <asp:Button ID="btnAddProducer" runat="server" Style="float: right" Text="Add Producer" OnClick="btnAddProducer_Click" CssClass="btn-danger" />
                                            <asp:Button ID="btnAddActor" runat="server" Style="float: right" Text="Add Actor" OnClick="btnAddActor_Click1" CssClass="btn-danger" />
                                        </span>
                                        </h4>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div style="text-align: center">
                                    <strong>
                                        <asp:Label ID="lblMsg" runat="server"></asp:Label>
                                    </strong>
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
                                <div class="col-sm-12">
                                    <div class="panel panel-bd lobidrag">
                                        <div class="panel-body">
                                            <div class="col-sm-3 form-group">
                                                <label>Actor Name</label>
                                                <ajaxa:AutoCompleteExtender ServiceMethod="GetActorNameList"
                                                    runat="server"
                                                    MinimumPrefixLength="2"
                                                    CompletionInterval="10"
                                                    EnableCaching="false"
                                                    CompletionSetCount="5"
                                                    TargetControlID="txtActorName"
                                                    ID="AutoCompleteExtender1"
                                                    CompletionListCssClass="completionList"
                                                    CompletionListHighlightedItemCssClass="itemHighlighted"
                                                    CompletionListItemCssClass="listItem"
                                                    OnClientItemSelected="ClientItemSelectedname"
                                                    OnClientPopulated="OnClientCompleted"
                                                    OnClientPopulating="OnClientPopulating"
                                                    ServicePath="manage-movies.aspx"
                                                    FirstRowSelected="false">
                                                </ajaxa:AutoCompleteExtender>
                                                <asp:TextBox ID="txtActorName" placeholder="Actor Name" runat="server" CssClass="form-control"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ForeColor="Red" ValidationGroup="a1" ErrorMessage="Actor name is required" ControlToValidate="txtActorName"></asp:RequiredFieldValidator>
                                            </div>

                                            <div class="col-sm-3 form-group">
                                                <label>Add Actor</label>
                                                <br />
                                                <asp:Button ID="btngridviewadd" runat="server" Text="Add Actor/Actress" class="btn btn-success" OnClick="btngridviewadd_Click" ValidationGroup="a1" />
                                                <asp:Label ID="lblmsg1" runat="server"></asp:Label>
                                            </div>
                                            <%--  here table code starts --%>
                                            <div class="col-sm-12">
                                                <asp:GridView ID="grActorList" class="table table-bordered table-hover" runat="server" AutoGenerateColumns="false">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Actor/Actress Name">
                                                            <ItemTemplate>
                                                                <%#Eval("ActorName")%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="BIO">
                                                            <ItemTemplate>
                                                                <%#Eval("BIO")%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Delete">
                                                            <ItemTemplate>
                                                                <a href="#" onclick="return confirm('Are you sure you want to Delete this Actor/Actress.')">
                                                                    <asp:ImageButton ID="lbDelete" runat="server" Text="Delete" OnClick="lbDelete_Click" CommandArgument='<%#Eval("ActorId") %>' ImageUrl="~/images/delete.png" Width="25"></asp:ImageButton>
                                                                </a>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <%--this is style for gridview--%>
                                                    <EditRowStyle BackColor="#2461BF" />
                                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                    <RowStyle BackColor="#EFF3FB" />
                                                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                                                </asp:GridView>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <div class="col-sm-4 form-group">
                                        <asp:Button ID="btnSubmit" ValidationGroup="g3" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="btn-info btn" />
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <asp:Panel ID="pnl2" runat="server" Visible="false">
                    <div class="panel panel-bd" id="drg2">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <h4>Add Producer</h4>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="col-sm-12" style="text-align: center">
                                <asp:Label ID="lblMsgProducer" runat="server" Style="font-weight: 700"></asp:Label>
                            </div>
                            <div class="col-sm-12">
                                <div class="col-sm-12 form-group">
                                    <div class="col-sm-2">
                                        <label>Name</label>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="txtProducerNamePop" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-2">
                                        <label>DOB</label>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="txtProducerDOBPop" runat="server" CssClass="form-control"></asp:TextBox>
                                        <ajaxa:CalendarExtender ID="CalendarExtender3" runat="server"
                                            CssClass="cal_Theme1" Format="dd/MM/yyyy" PopupPosition="Left"
                                            TargetControlID="txtProducerDOBPop"></ajaxa:CalendarExtender>
                                    </div>
                                </div>
                                <div class="col-sm-12 form-group">
                                    <div class="col-sm-2">
                                        <label>Gender</label>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:DropDownList ID="ddlProducerGenderPop" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="1" Text="Male"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="Female"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-2">
                                        <label>BIO</label>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="txtProducerBIOPop" TextMode="MultiLine" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="btn-group col-sm-12" style="text-align: center">
                                    <div class="col-lg-2">
                                        <asp:Button ID="btnProducerAdd" runat="server" ValidationGroup="c2" class="btn btn-success" OnClick="btnProducerAdd_Click" Text="Submit"></asp:Button>
                                    </div>
                                    <div class="col-lg-4">
                                        <asp:Button ID="btncloseProducer" runat="server" OnClick="btncloseProducer_Click" class="btn btn-warning" Text="Close" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pn1" runat="server" Visible="false">
                    <div class="panel panel-bd" id="drg">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <h4>Add Actor/Actress</h4>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="col-sm-12" style="text-align: center">
                                <asp:Label ID="lblPopUpActor" runat="server" Style="font-weight: 700"></asp:Label>
                            </div>
                            <div class="col-sm-12">
                                <div class="col-sm-12 form-group">
                                    <div class="col-sm-2">
                                        <label>Name</label>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="txtActorNamePop2" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-2">
                                        <label>DOB</label>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="txtActorDobPop2" runat="server" CssClass="form-control"></asp:TextBox>
                                        <ajaxa:CalendarExtender ID="CalendarExtender1" runat="server"
                                            CssClass="cal_Theme1" Format="dd/MM/yyyy" PopupPosition="Right"
                                            TargetControlID="txtActorDobPop2"></ajaxa:CalendarExtender>
                                    </div>
                                </div>
                                <div class="col-sm-12 form-group">
                                    <div class="col-sm-2">
                                        <label>Gender</label>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:DropDownList ID="ddlActorGenderPop2" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="1" Text="Male"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="Female"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-2">
                                        <label>BIO</label>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="txtActorBioPop2" TextMode="MultiLine" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="btn-group col-sm-12" style="text-align: center">
                                    <div class="col-lg-2">
                                        <asp:Button ID="btnAddNewActor" runat="server" ValidationGroup="c2" class="btn btn-success" OnClick="btnAddNewActor_Click" Text="Submit"></asp:Button>
                                    </div>
                                    <div class="col-lg-4">
                                        <asp:Button ID="btnCancel" runat="server" class="btn btn-warning" OnClick="btnCancel_Click" Text="Close" />
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
        function ClientItemSelectedname(sender, e) {
            $get("<%=txtActorName.ClientID%>").style.backgroundColor = "#dbe6e2";
        }
        function OnClientPopulating(sender, e) {
            sender._element.className = "form-control loading";
        }

        function OnClientCompleted(sender, e) {
            sender._element.className = "form-control";
        }
    </script>
</asp:Content>
