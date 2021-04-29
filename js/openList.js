function Player(p){
    this.Name = p.Name;
    this.Position = p.Position;
    this.Class = p.Class;
    this.School = p.School;
    this.Description = p.Name + " - " + p.Position + " - " + p.School;
};

function findPlayer(player, models){
    if (!player)
        return null;
    return models.filter(function(m){
        return m.Description === player;
    })[0];
}

var playerModels = players.map(function(p) {
    return new Player(p);
});
var model = {
    players: playerModels,
    caption: "Choose..."
};
for (var i = 0; i < 10; i++){
    model['pick' + (i + 1)] = ko.observable(findPlayer(picks[i], playerModels));
}
ko.applyBindings(model, document.getElementById("players"));

function resolvePicks(){
    var selections = [];
    for (var i = 1; i < 11; i++){
        var selection = model['pick' + i]() || {"Description": null};
        selections.push(selection.Description);
    }
    return selections;
}

function savePicks(key){
    $.post("/" + key, JSON.stringify(resolvePicks())).done(function(){alert("Saved")});
}