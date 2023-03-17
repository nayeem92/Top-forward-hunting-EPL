Select *
From epl_player_shots..sca_gca
Order by 5

Select *
From epl_player_shots..shots_ratio
Order by 5

----------relevant data

Select [Player], [G/Sh], Dist, xG, npxG, [G-xG], [np:G-xG]
From epl_player_shots..shots_ratio

----------likelihood of scoring a goal with high xG

Select [Player],Gls, xG
From epl_player_shots..shots_ratio
Order by 2

-----------which country produces the best goal scorers
Select Nation, Max(Gls) as GoalScored
From epl_player_shots..shots_ratio
Group by Nation
Order by 2 Desc

-----how many norweigner is in my datase?
Select Player, Nation, Gls
from epl_player_shots..shots_ratio
Where Nation like '%NOR%'

---------joining both tables, sca_gca vs shot ratios
Select *
From epl_player_shots..sca_gca
Join epl_player_shots..shots_ratio
On sca_gca.Player = shots_ratio.Player

-------for further analysis
Select sca_gca.Player, sca_gca.Nation, SCA90, GCA90, sca_gca.Squad, [G/Sh], [np:G-xG]
From epl_player_shots..sca_gca
Join epl_player_shots..shots_ratio
On sca_gca.Player = shots_ratio.Player
Where [G/Sh] is not null

------let's see Haaland's info
Select sca_gca.Player, sca_gca.SCA90, sca_gca.GCA90, shots_ratio.[SoT%], shots_ratio.[G/Sh], shots_ratio.[G/SoT], shots_ratio.xG, shots_ratio.[G-xG], shots_ratio.[np:G-xG]
From epl_player_shots..sca_gca
Join epl_player_shots..shots_ratio
On sca_gca.Player = shots_ratio.Player
Where sca_gca.Player = 'Erling Haaland'

----------forwards info
Select sca_gca.Player, sca_gca.Pos, sca_gca.SCA90, sca_gca.GCA90, shots_ratio.[SoT%], shots_ratio.[G/Sh], shots_ratio.[G/SoT], shots_ratio.xG, shots_ratio.[G-xG], shots_ratio.[np:G-xG]
From epl_player_shots..sca_gca
Join epl_player_shots..shots_ratio
On sca_gca.Player = shots_ratio.Player
Where sca_gca.Pos = 'FW'
Order by sca_gca.SCA90, sca_gca.GCA90, shots_ratio.[SoT%], shots_ratio.[G/Sh], shots_ratio.[G/SoT], shots_ratio.xG, shots_ratio.[G-xG], shots_ratio.[np:G-xG] desc

-----aveage
Select avg(sca_gca.SCA90), avg(sca_gca.GCA90), avg(shots_ratio.[SoT%]), avg(shots_ratio.[G/Sh]), avg(shots_ratio.[G/SoT]), avg(shots_ratio.xG), avg(shots_ratio.[G-xG]), avg(shots_ratio.[np:G-xG])
From epl_player_shots..sca_gca
Join epl_player_shots..shots_ratio
On sca_gca.Player = shots_ratio.Player
Where sca_gca.Pos = 'FW'

------query forwards better than average values
Select sca_gca.Player, sca_gca.Pos, sca_gca.SCA90, sca_gca.GCA90, shots_ratio.[SoT%], shots_ratio.[G/Sh], shots_ratio.[G/SoT], shots_ratio.xG, shots_ratio.[G-xG], shots_ratio.[np:G-xG]
From epl_player_shots..sca_gca
Join epl_player_shots..shots_ratio
On sca_gca.Player = shots_ratio.Player
Where sca_gca.Pos = 'FW' AND shots_ratio.[G/Sh] > 0.11 AND shots_ratio.[G/SoT] > 0.28 AND shots_ratio.xG > 3.36 AND shots_ratio.[G-xG] > -0.034 AND shots_ratio.[np:G-xG]> -0.04
Order by shots_ratio.[G/Sh], shots_ratio.[G/SoT], shots_ratio.xG, shots_ratio.[G-xG], shots_ratio.[np:G-xG] desc