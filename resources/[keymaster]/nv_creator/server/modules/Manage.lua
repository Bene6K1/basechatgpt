Manage = {}
Manage.__index = Manage

Manage.nextBucket = 1
Manage.playerBucket = {}

function Manage:SetPlayerInPlace(playerId)
    local bucket = self.nextBucket

    self.nextBucket = self.nextBucket + 1
    self.playerBucket[playerId] = bucket

    SetPlayerRoutingBucket(playerId, bucket)
end

function Manage:ResetPlayerInstance(playerId)
    SetPlayerRoutingBucket(playerId, 0)

    self.playerBucket[playerId] = nil
end