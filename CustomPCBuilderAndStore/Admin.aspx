<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="CustomPCBuilderAndStore.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-box {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 520px;
            margin-bottom: 30px;
        }

        .msg{
            margin-top: 20px;
        }

        .logout-btn {
            float: right;
            background: #e94560;
            color: white;
            padding: 8px 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 13px;
            font-weight: bold;
        }

        .form-row {
            display: grid;
            grid-template-columns: 140px 1fr;
            align-items: center;
            margin-bottom: 15px;
        }

        .form-row label {
             font-weight: 600;
             color: #333;
             font-size: 14px;
        }

        .txt, .ddl, .file {
            width: 100%;
            height: 36px;
            padding: 6px 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
            transition: all 0.3s ease;
        }


        .txt:hover, .ddl:hover, .file:hover {
                border-color: #e94560;
        }


        .txt:focus, .ddl:focus {
                outline: none;
                border-color: #1a1a2e;
                box-shadow: 0 0 5px rgba(26,26,46,0.3);
        }


        .btn-add {
            width: 100%;
            background: #1a1a2e;
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            margin-top: 5px;
            transition: 0.3s;
        }

        .btn-add:hover {
                background: #e94560;
                transform: translateY(-2px);
        }

        .btn-delete {
            background: #e94560;
            color: white;
            padding: 5px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.3s;
        }

       .btn-delete:hover {
                background: #c82333;
       }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        th {
            background: #1a1a2e;
            color: white;
            padding: 12px;
            text-align: left;
            font-size: 13px;
        }

        td {
            padding: 10px 12px;
            border-bottom: 1px solid #eee;
            font-size: 13px;
        }

        tr:hover td {
            background: #f9f9f9;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Button ID="btnLogout" Text="Logout" runat="server" CssClass="logout-btn" OnClick="btnLogout_Click" />
    <h2 style="text-align: center; margin-top: 15px; margin-left: 60px; margin-bottom: 10px;">Admin Panel — Manage Products</h2>

    <span style="float: right;margin-right:15px; margin-top:8px; 
    background:#1a1a2e; color:#e94560; padding:8px 18px; 
    border-radius:20px; font-size:13px; font-weight:bold;">
     <%="Welcome " +  Session["Email"] %>
</span>

    <!-- Add Product Form -->
    <div class="form-box">
        <h3 style="margin-bottom: 20px; color: #e94560;">+ Add New Product</h3>
        <div class="form-row">
            <asp:Label Text="Product Name" runat="server"></asp:Label>
            <asp:TextBox ID="txtProductName" runat="server" CssClass="txt"></asp:TextBox>
        </div>

        <div class="form-row">
            <asp:Label Text="Category" runat="server"></asp:Label>
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="ddl">
                <asp:ListItem Text="CPU" Value="CPU" />
                <asp:ListItem Text="GPU" Value="GPU" />
                <asp:ListItem Text="RAM" Value="RAM" />
                <asp:ListItem Text="Storage" Value="Storage" />
                <asp:ListItem Text="Motherboard" Value="Motherboard" />
                <asp:ListItem Text="PSU" Value="PSU" />
                <asp:ListItem Text="Cooling" Value="Cooling" />
                <asp:ListItem Text="Case" Value="Case" />
            </asp:DropDownList>
        </div>

        <div class="form-row">
            <asp:Label Text="Price (PKR)" runat="server"></asp:Label>
            <asp:TextBox ID="txtPrice" runat="server" CssClass="txt"></asp:TextBox>
        </div>

        <div class="form-row">
            <asp:Label Text="Stock" runat="server"></asp:Label>
            <asp:TextBox ID="txtStock" runat="server" CssClass="txt"></asp:TextBox>
        </div>

        <div class="form-row">
            <asp:Label Text="Upload Image" runat="server"></asp:Label>
            <asp:FileUpload ID="FileUpload1" runat="server" CssClass="file" />
        </div>

        <div class="form-row">
            <asp:Label Text="Description" runat="server"></asp:Label>
            <asp:TextBox ID="txtDescription" runat="server" CssClass="txt"></asp:TextBox>
        </div>

        <asp:Button ID="btnAddProduct" Text="Add Product" runat="server" CssClass="btn-add" OnClick="btnAddProduct_Click" />
        <div>
        <asp:Label ID="lblMsg" runat="server" CssClass="msg"></asp:Label>
            </div>
    </div>


    <!-- Products Table -->
    <h3 style="margin-bottom: 15px; color: #1a1a2e;">All Products</h3>
    <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False"
        OnRowCommand="gvProducts_RowCommand"
        EmptyDataText="No products found.">
        <Columns>
            <asp:BoundField DataField="ProductID" HeaderText="ID" />
            <asp:BoundField DataField="ProductName" HeaderText="Name" />
            <asp:BoundField DataField="Category" HeaderText="Category" />
            <asp:BoundField DataField="Price" HeaderText="Price (PKR)" />
            <asp:BoundField DataField="Stock" HeaderText="Stock" />
            <asp:ButtonField CommandName="DeleteProduct" Text="Delete"
                ButtonType="Button" ControlStyle-CssClass="btn-delete" />
        </Columns>
    </asp:GridView>





</asp:Content>
