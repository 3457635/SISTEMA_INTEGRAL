<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Nuevo_Usuario.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Nuevo_Usuario" 
    title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">





    <asp:CreateUserWizard ID="RegisterUserWithRoles" runat="server" 
    LoginCreatedUser="False">
    <WizardSteps>
        <asp:CreateUserWizardStep runat="server" />
        <asp:WizardStep ID="SpecifyRolesStep" runat="server" AllowReturn="False" 
            StepType="Step" Title=" Specify Roles">
            <asp:CheckBoxList ID="RoleList" runat="server">
            </asp:CheckBoxList>
        </asp:WizardStep>
        <asp:CompleteWizardStep runat="server">
            <ContentTemplate>
                <table border="0">
                    <tr>
                        <td align="center" colspan="2">
                            Complete</td>
                    </tr>
                    <tr>
                        <td>
                            Your account has been successfully created.</td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2">
                            <asp:Button ID="ContinueButton" runat="server" CausesValidation="False" 
                                CommandName="Continue" PostBackUrl="~/Login.aspx" Text="Continue" 
                                ValidationGroup="CreateUserWizard1" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:CompleteWizardStep>
    </WizardSteps>
</asp:CreateUserWizard>





</asp:Content>
