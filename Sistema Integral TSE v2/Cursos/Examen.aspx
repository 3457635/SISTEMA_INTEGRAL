<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Examen.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Examen" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .auto-style4 {
            width: 100%;
        }
        .auto-style6 {
            width: 407px;
        }
        .btn {
        background-position: 0% 0%;
            background-image: linear-gradient(to bottom, #2d8f1e, #2d8f1e);
            -webkit-border-radius: 28;
            -moz-border-radius: 28;
            border-radius: 28px;
            font-family: Arial;
            color: #ffffff;
            font-size: 15px;
            padding: 8px 11px 8px 11px;
            text-decoration: none;
            margin-left: 0px;
            background-color: #2d8f1e;
            background-repeat: repeat;
            background-attachment: scroll;
        }

.btn:hover {
  background: #359766;
  background-image: -webkit-linear-gradient(top, #359766, #359766);
  background-image: -moz-linear-gradient(top, #359766, #359766);
  background-image: -ms-linear-gradient(top, #359766, #359766);
  background-image: -o-linear-gradient(top, #359766, #359766);
  background-image: linear-gradient(to bottom, #359766, #359766);
  text-decoration: none;
}
        .auto-style9 {
        }
        .auto-style10 {
            width: 433px;
        }
        .auto-style11 {
            height: 22px;
        }
        .auto-style12 {
            font-weight: bold;
        }
        .auto-style13 {
            height: 44px;
        }
        .auto-style14 {
            height: 39px;
        }
        .auto-style15 {
            height: 35px;
        }
        .auto-style16 {
            width: 439px;
        }
        .auto-style17 {
            height: 53px;
        }
        .auto-style18 {
            color: #FF0000;
            font-weight: bold;
        }
        .auto-style19 {
            width: 439px;
            height: 79px;
        }
        .auto-style20 {
            height: 79px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="auto-style4">
        <tr>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style9" colspan="2">
                <asp:Label ID="lblInstruc" runat="server" style="font-weight: 700" Text="Instrucciones:"></asp:Label>
                &nbsp;<asp:Label ID="lblInst" runat="server" Text="Antes de comenzar el examen solicite al encargado de Recursos Humanos la clave para iniciar."></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="text-align: right" class="auto-style10">
                <asp:Label ID="lblClave" runat="server" style="font-weight: 700" Text="Clave de acceso:"></asp:Label>
            &nbsp;<asp:TextBox ID="txtClave" runat="server" TextMode="Password" Width="172px"></asp:TextBox>
            </td>
            <td class="auto-style6">
                <asp:Button ID="btnIniciar" runat="server" Text="Iniciar" CssClass="btn" Height="40px" />
            </td>
        </tr>
        </table>
    <br />
    <asp:Panel ID="pnlExam" runat="server" Height="1331px" Visible="False">
        <table class="auto-style4">
            <tr>
                <td>
                    <asp:Label ID="lblFecha" runat="server" style="font-weight: 700" Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style11">
                    <asp:Label ID="lblNombre" runat="server" CssClass="auto-style12" Text="Nombre"></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtNombre" runat="server" Width="267px"></asp:TextBox>
                    <br />
                    <br />
                    <asp:Label ID="lblAp" runat="server" CssClass="auto-style12" Text="Apellido"></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtApellido" runat="server" Width="267px"></asp:TextBox>
                    &nbsp; </td>
            </tr>

            <tr>
                <td class="auto-style15">
                    <asp:Label ID="q1" runat="server" CssClass="auto-style12"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style13">
                    <asp:RadioButton ID="rb1" runat="server" GroupName="R1" />
                    <br />
                    <asp:RadioButton ID="rb2" runat="server" GroupName="R1" />
                    <br />
                    <asp:RadioButton ID="rb3" runat="server" GroupName="R1" />
                </td>
            </tr>
            <tr>
                <td class="auto-style15">
                    <asp:Label ID="q2" runat="server" CssClass="auto-style12"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style14">
                    <asp:RadioButton ID="rb4" runat="server" GroupName="R2" />
                    <br />
                    <asp:RadioButton ID="rb5" runat="server" GroupName="R2" />
                    <br />
                    <asp:RadioButton ID="rb6" runat="server" GroupName="R2" />
                </td>
            </tr>
            <tr>
                <td class="auto-style15">
                    <asp:Label ID="q3" runat="server" CssClass="auto-style12"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style11">
                    <asp:RadioButton ID="rb7" runat="server" GroupName="R3" />
                    <br />
                    <asp:RadioButton ID="rb8" runat="server" GroupName="R3" />
                    <br />
                    <asp:RadioButton ID="rb9" runat="server" GroupName="R3" />
                </td>
            </tr>
            <tr>
                <td class="auto-style15">
                    <asp:Label ID="q4" runat="server" CssClass="auto-style12"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style11">
                    <asp:RadioButton ID="rb10" runat="server" GroupName="R4" />
                    <br />
                    <asp:RadioButton ID="rb11" runat="server" GroupName="R4" />
                    <br />
                    <asp:RadioButton ID="rb12" runat="server" GroupName="R4" />
                </td>
            </tr>
            <tr>
                <td class="auto-style15">
                    <asp:Label ID="q5" runat="server" CssClass="auto-style12"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style11">
                    <asp:RadioButton ID="rb13" runat="server" GroupName="R5" />
                    <br />
                    <asp:RadioButton ID="rb14" runat="server" GroupName="R5" />
                    <br />
                    <asp:RadioButton ID="rb15" runat="server" GroupName="R5" />
                </td>
            </tr>
            <tr>
                <td class="auto-style15">
                    <asp:Label ID="q6" runat="server" CssClass="auto-style12"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style11">
                    <asp:RadioButton ID="rb16" runat="server" GroupName="R6" />
                    <br />
                    <asp:RadioButton ID="rb17" runat="server" GroupName="R6" />
                    <br />
                    <asp:RadioButton ID="rb18" runat="server" GroupName="R6" />
                </td>
            </tr>
            <tr>
                <td class="auto-style15">
                    <asp:Label ID="q7" runat="server" CssClass="auto-style12"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style11">
                    <asp:RadioButton ID="rb19" runat="server" GroupName="R7" />
                    <br />
                    <asp:RadioButton ID="rb20" runat="server" GroupName="R7" />
                    <br />
                    <asp:RadioButton ID="rb21" runat="server" GroupName="R7" />
                </td>
            </tr>
            <tr>
                <td class="auto-style15">
                    <asp:Label ID="q8" runat="server" CssClass="auto-style12"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style11">
                    <asp:RadioButton ID="rb22" runat="server" GroupName="R8" />
                    <br />
                    <asp:RadioButton ID="rb23" runat="server" GroupName="R8" />
                    <br />
                    <asp:RadioButton ID="rb24" runat="server" GroupName="R8" />
                </td>
            </tr>
            <tr>
                <td class="auto-style15">
                    <asp:Label ID="q9" runat="server" CssClass="auto-style12"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style11">
                    <asp:RadioButton ID="rb25" runat="server" GroupName="R9" />
                    <br />
                    <asp:RadioButton ID="rb26" runat="server" GroupName="R9" />
                    <br />
                    <asp:RadioButton ID="rb27" runat="server" GroupName="R9" />
                    <br />
                </td>
            </tr>
            <tr>
                <td class="auto-style15">
                    <asp:Label ID="q10" runat="server" CssClass="auto-style12"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style11">
                    <asp:RadioButton ID="rb28" runat="server" GroupName="R10" />
                    <br />
                    <asp:RadioButton ID="rb29" runat="server" GroupName="R10" />
                    <br />
                    <asp:RadioButton ID="rb30" runat="server" GroupName="R10" />
                </td>
            </tr>
            <tr>
                <td class="auto-style11">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style11">
                    <asp:Button ID="btnCalificar" runat="server" CssClass="btn" Height="40px" Text="Terminar" />
                </td>
            </tr>

        </table>
        <br />
        <asp:SqlDataSource ID="SqlExamen" runat="server" ConnectionString="Data Source=rtbygfdtxb.database.windows.net;Initial Catalog=tse_erp;User ID=omarifr;Password=Ifrramo2." ProviderName="System.Data.SqlClient" SelectCommand="SELECT TOP (10) * FROM PreguntasInduccion" InsertCommand="INSERT INTO ExamenInduccion(Nombre, Apellido, FechaExamen, Calificacion, Comentario) VALUES (@n,@ap,@fecha,@cali,@comen)">
            <InsertParameters>
                <asp:ControlParameter ControlID="txtNombre" Name="n" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtApellido" Name="ap" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblFecha" Name="fecha" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblCali" Name="cali" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtComentario" Name="comen" PropertyName="Text" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="gvPreguntas" runat="server" DataSourceID="SqlExamen" Visible="False">
        </asp:GridView>
        <br />
    </asp:Panel>
    <asp:Panel ID="pnlCalif" runat="server" Height="70px" Visible="False">
        <table class="auto-style4">
            <tr>
                <td class="auto-style17" colspan="2" style="text-align: center">
                    <asp:Label ID="lblCalif" runat="server" style="font-weight: 700; color: #0066CC" Text="CALIFICACION"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style16">
                    <asp:Label ID="lblObtenido" runat="server" style="font-weight: 700" Text="TU CALIFICACION:"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblCali" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style16">
                    <asp:Label ID="Label2" runat="server" style="color: #009900; font-weight: 700" Text="ACIERTOS"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblAciertos" runat="server" style="color: #009900; font-weight: 700"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style16">
                    <asp:Label ID="Label3" runat="server" CssClass="auto-style18" Text="FALLAS"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblFallas" runat="server" CssClass="auto-style18"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="auto-style19">
                    <asp:Label ID="lblComent" runat="server" style="font-weight: 700" Text="COMENTARIO"></asp:Label>
                </td>
                <td class="auto-style20">
                    <asp:TextBox ID="txtComentario" runat="server" Height="54px" TextMode="MultiLine" Width="375px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style16">&nbsp;</td>
                <td>
                    <asp:Button ID="btnAceptar" runat="server" CssClass="btn" Height="38px" Text="Aceptar" Width="86px" />
                </td>
            </tr>
        </table>
        


    </asp:Panel>
    
</asp:Content>
