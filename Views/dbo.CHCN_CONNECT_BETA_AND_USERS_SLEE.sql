SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[CHCN_CONNECT_BETA_AND_USERS_SLEE]
AS
SELECT dbo.CHCN_CONNECT2_usersAdm_SLEE.UserID, dbo.CHCN_CONNECT2_usersAdm_SLEE.Username AS Expr1, dbo.CHCN_CONNECT2_usersAdm_SLEE.Email, 
                  dbo.CHCN_CONNECT2_usersAdm_SLEE.UsersDisplayNm, dbo.CHCN_CONNECT2_usersAdm_SLEE.RoleName, 
                  dbo.CHCN_CONNECT2_usersAdm_SLEE.RoleNameDisplayNM, dbo.CHCN_CONNECT2_usersAdm_SLEE.FirstName, dbo.CHCN_CONNECT2_usersAdm_SLEE.LastName, 
                  dbo.CHCN_CONNECT2_usersAdm_SLEE.RoleUserid, dbo.CHCN_CONNECT2_usersAdm_SLEE.RoleUserName, dbo.CHCN_CONNECT2_usersAdm_SLEE.RoleEmail, 
                  dbo.CHCN_CONNECT2_usersAdm_SLEE.Status AS Expr2, dbo.CHCN_CONNECT2_usersAdm_SLEE.CreatedOnDate, dbo.CHCN_CONNECT2_usersAdm_SLEE.UserPhoneNO, 
                  dbo.CHCN_CONNECT2_usersAdm_SLEE.NPI, dbo.CHCN_CONNECT2_usersAdm_SLEE.ActivatedDate, dbo.CHCN_CONNECT2_usersAdm_SLEE.IsActivated, 
                  dbo.Chcn_Connect_Beta.CBETA, dbo.Chcn_Connect_Beta.RequestID, dbo.Chcn_Connect_Beta.ConnectContactNM, dbo.Chcn_Connect_Beta.ConnectContactPH, 
                  dbo.Chcn_Connect_Beta.AUTHNO, dbo.Chcn_Connect_Beta.STATUS, dbo.Chcn_Connect_Beta.PRIORITYSTATUS, dbo.Chcn_Connect_Beta.PLACESVC, 
                  dbo.Chcn_Connect_Beta.MEMBID, dbo.Chcn_Connect_Beta.MEMBNAME, dbo.Chcn_Connect_Beta.OPT, dbo.Chcn_Connect_Beta.REQDATE, 
                  dbo.Chcn_Connect_Beta.AUTHDATE, dbo.Chcn_Connect_Beta.EXPRDATE, dbo.Chcn_Connect_Beta.AUTHPCP, dbo.Chcn_Connect_Beta.AuthPCPVendID, 
                  dbo.Chcn_Connect_Beta.AuthPCPVendNM, dbo.Chcn_Connect_Beta.REQPROV, dbo.Chcn_Connect_Beta.ReqedVendorNM, dbo.Chcn_Connect_Beta.DEFAULT_YN, 
                  dbo.Chcn_Connect_Beta.User_no, dbo.Chcn_Connect_Beta.UserName, dbo.Chcn_Connect_Beta.Currentdt, dbo.Chcn_Connect_Beta.ConUserid, 
                  dbo.Chcn_Connect_Beta.ConAdmUserid, dbo.Chcn_Connect_Beta.ConAdmTaxid, dbo.Chcn_Connect_Beta.ConAdmNPI, dbo.Chcn_Connect_Beta.ConAdmEnterDate
FROM     dbo.CHCN_CONNECT2_usersAdm_SLEE LEFT OUTER JOIN
                  dbo.Chcn_Connect_Beta ON dbo.CHCN_CONNECT2_usersAdm_SLEE.UserID = dbo.Chcn_Connect_Beta.ConUserid

GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CHCN_CONNECT2_usersAdm_SLEE"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 168
               Right = 290
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Chcn_Connect_Beta"
            Begin Extent = 
               Top = 7
               Left = 338
               Bottom = 168
               Right = 562
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'CHCN_CONNECT_BETA_AND_USERS_SLEE', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'CHCN_CONNECT_BETA_AND_USERS_SLEE', NULL, NULL
GO
