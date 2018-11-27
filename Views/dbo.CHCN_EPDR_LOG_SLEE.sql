SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[CHCN_EPDR_LOG_SLEE]
AS
SELECT        TOP (100) PERCENT dbo.CHCNPDR_Master.RequestID, dbo.CHCNPDR_Master.ManagerID, dbo.CHCNPDR_Master.ClaimNo AS ClaimNo_PDRMASTER, 
                         dbo.CHCNPDR_ClaimMulti.ClaimNo AS ClaimNo_Multi, dbo.CHCNPDR_ClaimMulti.Sequence, dbo.CHCNPDR_ClaimMulti.EnterDate AS EnterDate_ClaimMulti, 
                         dbo.CHCNPDR_Master.UserID, dbo.CHCNPDR_Master.Claim_VendorNM, dbo.CHCNPDR_Master.DisputeReason, dbo.CHCNPDR_Master.EZCAP_CaseNo, 
                         dbo.CHCNPDR_Master.EZCAP_PostDt, dbo.CHCNPDR_Master.EnterDate AS EnterDate_PDR_Master, dbo.CHCNPDR_Master.LastChangeBy, 
                         dbo.CHCNPDR_Master.LastChangeDate, dbo.CHCNPDR_Master.DraftMode, dbo.CHCNPDR_Master.Submitter_Company, 
                         dbo.CHCNPDR_Master.Submitter_ProvName, dbo.CHCNPDR_Master.Submitter_Phone, dbo.CHCNPDR_Master.DisputeType, 
                         dbo.CHCN_SLEE_LOCAL_ADMINS.Username, dbo.CHCN_SLEE_LOCAL_ADMINS.VENDORID, dbo.CHCN_SLEE_LOCAL_ADMINS.VENDORNM, 
                         dbo.CHCN_SLEE_LOCAL_ADMINS.FirstName, dbo.CHCN_SLEE_LOCAL_ADMINS.LastName
FROM            dbo.CHCNPDR_Master LEFT OUTER JOIN
                         dbo.CHCN_SLEE_LOCAL_ADMINS ON dbo.CHCNPDR_Master.UserID = dbo.CHCN_SLEE_LOCAL_ADMINS.UserID LEFT OUTER JOIN
                         dbo.CHCNPDR_ClaimMulti ON dbo.CHCNPDR_Master.RequestID = dbo.CHCNPDR_ClaimMulti.RequestID
ORDER BY ClaimNo_PDRMASTER

GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[10] 3) )"
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
         Top = -480
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CHCNPDR_Master"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 236
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CHCNPDR_ClaimMulti"
            Begin Extent = 
               Top = 7
               Left = 332
               Bottom = 162
               Right = 502
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "CHCN_SLEE_LOCAL_ADMINS"
            Begin Extent = 
               Top = 31
               Left = 808
               Bottom = 345
               Right = 1013
            End
            DisplayFlags = 280
            TopColumn = 7
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 16
         Width = 284
         Width = 1890
         Width = 1380
         Width = 2355
         Width = 2175
         Width = 1515
         Width = 1500
         Width = 915
         Width = 2685
         Width = 1500
         Width = 2625
         Width = 1500
         Width = 2235
         Width = 1500
         Width = 2790
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1995
         Alias = 1425
         Table = 2535
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
', 'SCHEMA', N'dbo', 'VIEW', N'CHCN_EPDR_LOG_SLEE', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=1
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'CHCN_EPDR_LOG_SLEE', NULL, NULL
GO
