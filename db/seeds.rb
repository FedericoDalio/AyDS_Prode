mUnited = Team.create(name:"Manchester United")
mCity = Team.create(name:"Manchester City")
astonVilla = Team.create(name:"Aston Villa")
westHam = Team.create(name:"West Ham United")
leeds = Team.create(name:"Leeds United")
chelsea = Team.create(name:"Chelsea")
liverpool = Team.create(name:"Liverpool")
tottenham = Team.create(name:"Tottenham")
arsenal = Team.create(name:"Arsenal FC")
leicester = Team.create(name:"Leicester City")
brighton = Team.create(name:"Brighton and Hove")
wolves = Team.create(name:"Wolveshampton")
newcastle = Team.create(name:"Newclaste")
crystalPalace = Team.create(name:"Crystal Palace")
brentford = Team.create(name:"Brentford")
southampton = Team.create(name:"Southampton")
everton = Team.create(name:"Everton")
fulham = Team.create(name:"Fulham")
bournemouth = Team.create(name:"Bournemouth")
nottingham = Team.create(name:"Nottingham Forest")
Match.create(local:fulham, visitor: everton, date:1)
Match.create(local:mUnited, visitor: wolves, date:1)
Match.create(local:mCity, visitor: leeds, date:1)
Match.create(local:chelsea, visitor: crystalPalace, date:1)
Match.create(local:newcastle, visitor: astonVilla, date:1)
Match.create(local:brighton, visitor: arsenal, date:1)
Match.create(local:leicester, visitor: nottingham, date:1)
Match.create(local:bournemouth, visitor: southampton, date:1)
Match.create(local:liverpool, visitor: westHam, date:1)
Match.create(local:brentford, visitor: tottenham, date:1)
Match.create(local:fulham, visitor: tottenham, date:2)
Match.create(local:westHam, visitor: wolves, date:2)
Match.create(local:mCity, visitor: bournemouth, date:2)
Match.create(local:leicester, visitor: crystalPalace, date:2)
Match.create(local:arsenal, visitor: astonVilla, date:2)
Match.create(local:brighton, visitor: newcastle, date:2)
Match.create(local:chelsea, visitor: nottingham, date:2)
Match.create(local:leeds, visitor: southampton, date:2)
Match.create(local:liverpool, visitor: mUnited, date:2)
Match.create(local:brentford, visitor: everton, date:2)
Match.create(local:brentford, visitor:leeds, date:3)
Match.create(local:chelsea, visitor:liverpool, date:3)
Match.create(local:arsenal, visitor:wolves, date:3)
Match.create(local:brighton, visitor:fulham, date:3)
Match.create(local:nottingham, visitor:mCity, date:3)
Match.create(local:bournemouth, visitor:westHam, date:3)
Match.create(local:tottenham, visitor:astonVilla, date:3)
Match.create(local:everton, visitor:crystalPalace, date:3)
Match.create(local:newcastle, visitor:mUnited, date:3)
Match.create(local:leicester, visitor:southampton, date:3)
Match.create(local:arsenal, visitor:nottingham, date:4)
Match.create(local:bournemouth, visitor:tottenham, date:4)
Match.create(local:everton, visitor:newcastle, date:4)
Match.create(local:leicester, visitor:leeds, date:4)
Match.create(local:liverpool, visitor:wolves, date:4)
Match.create(local:fulham, visitor:mCity, date:4)
Match.create(local:westHam, visitor:astonVilla, date:4)
Match.create(local:brighton, visitor:crystalPalace, date:4)
Match.create(local:mUnited, visitor:southampton, date:4)
Match.create(local:brentford, visitor:chelsea, date:4)