// Agent auctioneer3 in project testJaCaMo

/* Initial beliefs and rules */

/* Initial goals */

/* Plans */

+!start(Id,P)
   <- makeArtifact(Id, "auction.AuctionArtifact", [], ArtId); // [] -> params
      .print("Auction artifact created for ",P);
      Id::focus(ArtId);  // place observable properties of this auction in a particular name space
      Id::start(P);
      .broadcast(achieve,focus(Id));  // ask all others to focus on this new artifact
      .at("now + 5 seconds", {+!decide(Id)}).

+!decide(Id)
   <- Id::stop.

+NS::winner(W) : W \== no_winner //winner in the correct Name Space
   <- ?NS::task(S);
      ?NS::best_bid(V);
      .print("Winner for ", S, " is ",W," with ", V).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
