SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[CHCN_SLEE_LOCAL_ADMINS]
AS
SELECT        dbo.CHCN_CONNECT2_usersAdm_SLEE.CompanyID, dbo.CHCN_CONNECT2_usersAdm_SLEE.PropertyValue, dbo.CHCN_CONNECT2_usersAdm_SLEE.Seq, 
                         dbo.CHCN_CONNECT2_usersAdm_SLEE.PropertyCategory, dbo.CHCN_CONNECT2_usersAdm_SLEE.VENDORID, 
                         dbo.CHCN_CONNECT2_usersAdm_SLEE.VENDORNM, dbo.CHCN_CONNECT2_usersAdm_SLEE.UserID, dbo.CHCN_CONNECT2_usersAdm_SLEE.Username, 
                         dbo.CHCN_CONNECT2_usersAdm_SLEE.Email, dbo.CHCN_CONNECT2_usersAdm_SLEE.UsersDisplayNm, 
                         dbo.CHCN_CONNECT2_usersAdm_SLEE.CreatedByUserID, dbo.CHCN_CONNECT2_usersAdm_SLEE.CreatedONDt, 
                         dbo.CHCN_CONNECT2_usersAdm_SLEE.LastModifiedByUserID, dbo.CHCN_CONNECT2_usersAdm_SLEE.LastModifiedOnDate, 
                         dbo.CHCN_CONNECT2_usersAdm_SLEE.RoleName, dbo.CHCN_CONNECT2_usersAdm_SLEE.RoleNameDisplayNM, 
                         dbo.CHCN_CONNECT2_usersAdm_SLEE.FirstName, dbo.CHCN_CONNECT2_usersAdm_SLEE.LastName, dbo.CHCN_CONNECT2_usersAdm_SLEE.IsSuperUser, 
                         dbo.CHCN_CONNECT2_usersAdm_SLEE.Status, dbo.CHCN_CONNECT2_usersAdm_SLEE.CreatedOnDate, dbo.CHCN_CONNECT2_usersAdm_SLEE.Authorised, 
                         dbo.CHCN_CONTACT_PHONE.UserID AS UserIdPh, dbo.CHCN_CONTACT_PHONE.Username AS UsernamePH, 
                         dbo.CHCN_CONTACT_PHONE.PropertyCategory AS CategoryPH, dbo.CHCN_CONTACT_PHONE.UserPhoneNO, dbo.CHCN_CONNECT2_usersAdm_SLEE.NPI
FROM            dbo.CHCN_CONNECT2_usersAdm_SLEE LEFT OUTER JOIN
                         dbo.CHCN_CONTACT_PHONE ON dbo.CHCN_CONNECT2_usersAdm_SLEE.UsersID_ = dbo.CHCN_CONTACT_PHONE.UserID
WHERE        (dbo.CHCN_CONNECT2_usersAdm_SLEE.RoleName = 'LOCAL ADMIN')

GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[22] 4[16] 2[5] 3) )"
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
               Bottom = 204
               Right = 290
            End
            DisplayFlags = 280
            TopColumn = 23
         End
         Begin Table = "CHCN_CONTACT_PHONE"
            Begin Extent = 
               Top = 14
               Left = 447
               Bottom = 175
               Right = 658
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
      Begin ColumnWidths = 27
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2820
         Alias = 2850
         Table = 5460
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
', 'SCHEMA', N'dbo', 'VIEW', N'CHCN_SLEE_LOCAL_ADMINS', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'CHCN_SLEE_LOCAL_ADMINS', NULL, NULL
GO
