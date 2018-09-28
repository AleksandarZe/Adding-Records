<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="StyleSheet.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.12.4.js"></script>
    <script src="Scripts/jquery-ui-1.12.1.js"></script>
    
</head>
<body>
    <form id="form1" runat="server">
        <div id="main" style="position:absolute">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

       Enter Name: <asp:TextBox ID="txtName" runat="server" CssClass="boxes"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="Must Enter Name"></asp:RequiredFieldValidator>
            <br />
            Enter Email:  <asp:TextBox ID="txtEMail" runat="server" CssClass="boxes"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEMail" ErrorMessage="Must Enter Email"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEMail" ErrorMessage="Must Enter Valid EMail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            <br />

         
           Enter Date:   <asp:TextBox ID="txtDate" runat="server" CssClass="boxes" ReadOnly="True" OnTextChanged="txtDate_TextChanged"></asp:TextBox>
            <asp:CheckBox ID="CheckBox1" AutoPostBack="true" runat="server" Text="Check to show calendar" OnCheckedChanged="CheckBox1_CheckedChanged" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDate" ErrorMessage="Enter normal Date"></asp:RequiredFieldValidator>
            <br />
            

            <asp:updatepanel runat="server">
                <ContentTemplate>
<asp:Calendar ID="Calendar1" runat="server"  BackColor="White" BorderColor="White" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="350px" BorderWidth="1px" OnSelectionChanged="Calendar1_SelectionChanged" Visible="False">
            
            
                <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                <OtherMonthDayStyle ForeColor="#999999" />
                <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                <TitleStyle BackColor="White" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" BorderColor="Black" BorderWidth="4px" />
                <TodayDayStyle BackColor="#CCCCCC" />
            </asp:Calendar>
                </ContentTemplate>
            </asp:updatepanel>
                
           
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
            <br />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:CommandField CausesValidation="False" ShowEditButton="True" />
                    <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="EMail" HeaderText="EMail" SortExpression="EMail" />
                    <asp:TemplateField HeaderText="DateAdded" SortExpression="DateAdded">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("DateAdded") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("DateAdded", "{0:d}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
            <br />
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PersonTableConnString %>" DeleteCommand="DELETE FROM [PersonTable] WHERE [ID] = @ID" InsertCommand="INSERT INTO [PersonTable] ([Name], [EMail], [DateAdded]) VALUES (@Name, @EMail, @DateAdded)" SelectCommand="SELECT [ID], [Name], [EMail], [DateAdded] FROM [PersonTable]" UpdateCommand="UPDATE [PersonTable] SET [Name] = @Name, [EMail] = @EMail, [DateAdded] = @DateAdded WHERE [ID] = @ID">
            <DeleteParameters>
                <asp:Parameter Name="ID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="EMail" Type="String" />
                <asp:Parameter DbType="Date" Name="DateAdded" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="EMail" Type="String" />
                <asp:Parameter DbType="Date" Name="DateAdded" />
                <asp:Parameter Name="ID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
    <script>
        $(function () {
            $("#main").draggable()
            
            
            $(window).on('beforeunload', function () {
                var pos = $("#main").position()
                localStorage.setItem('dev',JSON.stringify(pos))
            });
            var topLeft = JSON.parse(localStorage.getItem('div'))
            $("#main").css(topLeft)
        });
    </script>
</body>
</html>
