#Esports Bet-Ethereum
Smart contract allows users to Bet on either Player 1 or Player 2. If they put ETH on the winner they are able to withdraw "POT" winnings back to their address. If not they lose the ETH bet. *Originally designed to allows users to bet TOKENS instead of ETH*

Owner Access:
- Owner can set "Pot" by sending ETH to the function *Not yet implemented but not hard to do. Will be added in next release*
- Make Player1 win / Make Player 2 win
- View Players bets
- Kill contract (receive ETH left in contract) *Commented out for now. WIll put back in next release*


Players Access:
- Send ETH to contract (Bet on Player1 / Player 2)
- View Bet (TeamA / TeamB)
- Collect winnings
- Withdraw funds (Funds cannot be withdrawn if user lost the bet)


