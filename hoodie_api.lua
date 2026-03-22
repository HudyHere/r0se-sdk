--- @meta

--[[----------------------------------------------------------------------------
    Vector3
    Defined in: HoodieSDK/Utility/Vector3.h
    Bound in: LuaPlugin::RegisterVector3Bindings
----------------------------------------------------------------------------]]

--- @class Vector3
--- @field x number The X component.
--- @field y number The Y component.
--- @field z number The Z component.
--- @operator add(Vector3): Vector3
--- @operator sub(Vector3): Vector3
--- @operator mul(number): Vector3
--- @operator div(number): Vector3
--- @operator unm: Vector3
Vector3 = {}

--- Creates a new Vector3.
--- @param x? number (Optional) Default: 0.0
--- @param y? number (Optional) Default: 0.0
--- @param z? number (Optional) Default: 0.0
--- @return Vector3
function Vector3.new(x, y, z) end

--- Returns the squared magnitude of the vector.
--- Faster than Length() as it avoids the square root calculation.
--- @return number
function Vector3:LengthSquared() end

--- Returns the magnitude (length) of the vector.
--- @return number
function Vector3:Length() end

--- Normalizes the vector in-place, making it a unit vector (length of 1).
--- @return Vector3 @Returns self (modified).
function Vector3:Normalize() end

--- Returns a new vector that is the normalized version of this vector.
--- Does not modify the original vector.
--- @return Vector3
function Vector3:Normalized() end

--- Checks if this vector is close to another vector within a specific tolerance.
--- @param other Vector3 The target vector to compare.
--- @param epsilon? number The tolerance range. Default: 1e-5.
--- @return boolean
function Vector3:IsNear(other, epsilon) end

--- Calculates the Euclidean distance between this vector and another vector.
--- @param other Vector3
--- @return number
function Vector3:Distance(other) end

--- Calculates the 2D (XY-plane only) distance between this vector and another vector.
--- Ignores the Z component entirely. Preferred for ground-plane distance checks.
--- @param other Vector3
--- @return number
function Vector3:Distance2D(other) end

--- Returns a copy of this vector with the Z component set to 0.
--- Useful for 2D calculations on the ground plane.
--- @return Vector3
function Vector3:ToVector2() end

--- Returns a new point extended from the current position towards a target position.
--- @param target Vector3 The target position to extend towards.
--- @param distance number The distance to extend.
--- @return Vector3
function Vector3:ExtendedInPosition(target, distance) end

--- Returns a new point extended from the current position in a specific direction.
--- @param rotation number The rotation angle (in degrees).
--- @param distance number The distance to extend.
--- @return Vector3
function Vector3:ExtendedInDirection(rotation, distance) end

--- Converts a rotation angle (in degrees) into a direction vector.
--- @param rotation number The rotation angle in degrees.
--- @return Vector3
function Vector3:GetDirFromRot(rotation) end

--- Calculates the rotation angle (in degrees) corresponding to this direction vector.
--- @return number
function Vector3:GetRotFromDir() end

--- Checks if this point lies within a circular sector (cone) defined by an origin and direction.
--- Useful for checking if a point is inside a Field of View (FOV).
--- @param origin Vector3 The starting point of the sector.
--- @param direction Vector3 The direction the sector is facing.
--- @param angle number The width of the sector in degrees (FOV).
--- @param radius number The maximum distance (range).
--- @return boolean
function Vector3:IsPointInsideSector(origin, direction, angle, radius) end

--- Checks if this point is within a circle defined by a center and radius.
--- @param center Vector3 The center of the circle.
--- @param radius number The radius of the circle.
--- @return boolean
function Vector3:IsInsideCircle(center, radius) end

--[[----------------------------------------------------------------------------
    Engine
    Defined in: Implementations/Engine/HoodieEngine.h
    Bound in: LuaPlugin::RegisterEngineBindings
----------------------------------------------------------------------------]]

--- @class Engine
Engine = {}

--- Returns the current system uptime in milliseconds.
--- Useful for measuring time intervals or cooldowns.
--- @return integer
function Engine:GetCurrentTime() end


--[[----------------------------------------------------------------------------
    Events
    Defined in: HoodieSDK/Events/EventTypes.h
    Bound in: LuaPlugin::RegisterEngineBindings
----------------------------------------------------------------------------]]

--- @class BaseEventArgs
BaseEventArgs = {}

--- @class SendSyncPositionPacketEventArgs : BaseEventArgs
--- @field vid integer The Virtual ID (VID) of the entity syncing position.
--- @field posX integer The global X coordinate.
--- @field posY integer The global Y coordinate.
SendSyncPositionPacketEventArgs = {}

--- @class AppendChatEventArgs : BaseEventArgs
--- @field chatType integer The type of chat (e.g., Global, Guild, Shout).
--- @field message string @readonly The content of the message.
AppendChatEventArgs = {}

--- @class AppendWhisperEventArgs : BaseEventArgs
--- @field chatType integer The type of whisper (e.g., GM, Normal).
--- @field sender string @readonly The name of the character sending the whisper.
--- @field message string @readonly The content of the message.
AppendWhisperEventArgs = {}

--- @class CancellableEventArgs : BaseEventArgs
--- Base class for events that can be cancelled.
CancellableEventArgs = {}

--- Prevents the default action from occurring.
--- @param prevent? boolean Default: true
function CancellableEventArgs:PreventCall(prevent) end

--- Checks if the default action has been prevented.
--- @return boolean
function CancellableEventArgs:IsCallPrevented() end

--- @class SendPacketEventArgs : CancellableEventArgs
--- Triggered when the client is about to send a packet to the server.
--- @field packetSize integer The size of the packet in bytes (can be modified).
--- @field packetData userdata Pointer to the packet data (can be modified).
--- @field returnAddress integer The return address (relative to module base, e.g., +0x12345).
SendPacketEventArgs = {}

--- Reads a single byte from the packet at the specified offset.
--- @param offset integer Zero-based byte offset.
--- @return integer|nil Returns nil if offset is out of bounds.
function SendPacketEventArgs:GetByte(offset) end

--- Reads the packet header (first byte).
--- @return integer|nil Returns nil if packet is empty.
function SendPacketEventArgs:GetHeader() end

--- @class RecvPacketEventArgs : BaseEventArgs
--- Triggered when the client receives a packet from the server.
--- @field packetSize integer @readonly The size of the packet in bytes.
--- @field packetData userdata @readonly Pointer to the packet data (read-only).
--- @field returnAddress integer @readonly The return address (relative to module base, e.g., +0x12345).
RecvPacketEventArgs = {}

--- Reads a single byte from the packet at the specified offset.
--- @param offset integer Zero-based byte offset.
--- @return integer|nil Returns nil if offset is out of bounds.
function RecvPacketEventArgs:GetByte(offset) end

--- Reads the packet header (first byte).
--- @return integer|nil Returns nil if packet is empty.
function RecvPacketEventArgs:GetHeader() end

--- @class SendChatPacketEventArgs : BaseEventArgs
--- @field message string @readonly The message being sent to the server.
--- @field type integer The chat packet type.
SendChatPacketEventArgs = {}

--- @class OnChannelEventArgs : BaseEventArgs
--- @field channel integer The channel ID that was just loaded.
OnChannelEventArgs = {}

--- @class FishingEffectEventArgs : BaseEventArgs
--- @field effectId integer The ID of the fishing effect (e.g., bubble, catch success/fail).
FishingEffectEventArgs = {}

--- @class SetEmoticonEventArgs : BaseEventArgs
--- @field instanceName string The name of the character/instance showing the emoticon.
--- @field emoticonId integer The ID of the emoticon being displayed.
SetEmoticonEventArgs = {}

--- @class AppUpdateEventArgs : BaseEventArgs
--- Triggered every application frame (render tick).
AppUpdateEventArgs = {}

--- @class GameUpdateEventArgs : BaseEventArgs
--- Triggered every game logic tick.
GameUpdateEventArgs = {}


--[[----------------------------------------------------------------------------
    Entity
    Defined in: Implementations/Entities/Entity.h
    Bound in: LuaPlugin::RegisterEntityBindings
----------------------------------------------------------------------------]]

--- @class Entity
Entity = {}

-- ==========================================================
-- 1. Identity & Type
-- ==========================================================

--- Returns the name of the entity.
--- @return string
function Entity:GetName() end

--- Returns the Virtual Number (VNUM) of the entity.
--- This is the static ID defined in the game files (e.g., Mob ID, Item ID).
--- @return integer
function Entity:GetVirtualNumber() end

--- Returns the Virtual ID (VID) of the entity.
--- This is the unique runtime identifier assigned by the server for this session.
--- @return integer
function Entity:GetVirtualID() end

--- Returns the instance type constant.
--- (e.g., 0=Enemy, 1=NPC, 2=Stone, etc.)
--- @return integer
function Entity:GetInstanceType() end

--- Returns the battle type of the mob.
--- @return integer
function Entity:GetMobBattleType() end

--- Returns the rank of the mob (e.g., Normal, Boss, Super Boss).
--- @return integer
function Entity:GetMobRank() end

-- ==========================================================
-- 2. State Booleans
-- ==========================================================

--- Checks if the entity is dead.
--- @return boolean
function Entity:IsDead() end

--- Checks if the entity is currently stunned.
--- @return boolean
function Entity:IsStunned() end

--- Checks if the entity is in a waiting (idle) state.
--- @return boolean
function Entity:IsWaiting() end

--- Checks if the entity is currently walking.
--- @return boolean
function Entity:IsWalking() end

--- Checks if the entity is performing an attack animation.
--- @return boolean
function Entity:IsAttacking() end

--- Checks if the entity is currently being attacked by someone else.
--- @return boolean
function Entity:IsAttacked() end

--- Checks if the entity is currently casting a skill.
--- @return boolean
function Entity:IsUsingSkill() end

--- Checks if the entity is currently mounting a horse.
--- @return boolean
function Entity:IsMountingHorse() end

-- ==========================================================
-- 3. Position & Movement
-- ==========================================================

--- Returns the current global position of the entity.
--- @return Vector3
function Entity:GetPosition() end

--- Returns the current rotation of the entity in degrees.
--- @return number
function Entity:GetRotation() end

--- Sets the client-side movement speed of the entity.
--- @param speed integer The new speed value.
function Entity:SetMoveSpeed(speed) end

-- ==========================================================
-- 4. Combat & Attributes
-- ==========================================================

--- Returns the weapon type constant of the equipped weapon.
--- @return integer
function Entity:GetWeaponType() end

--- Sets the combo animation type.
--- @param comboType integer
function Entity:SetComboType(comboType) end

--- Sets the client-side attack speed.
--- @param attackSpeed integer
function Entity:SetAttackSpeed(attackSpeed) end

--- Returns the current combo index of the entity.
--- @return integer
function Entity:GetComboIndex() end


--[[----------------------------------------------------------------------------
    Player
    Defined in: Implementations/Entities/Player.h
    Bound in: LuaPlugin::RegisterEntityBindings
----------------------------------------------------------------------------]]

--- @class Player
Player = {}

-- ==========================================================
-- 1. Validation & Identity
-- ==========================================================

--- Checks if the local player object is valid and ready.
--- @return boolean
function Player:IsValid() end

--- Returns the name of the local player.
--- @return string
function Player:GetName() end

--- Returns the VNUM (Job ID) of the local player.
--- @return integer
function Player:GetVirtualNumber() end

--- Returns the VID (Runtime ID) of the local player.
--- @return integer
function Player:GetVirtualID() end

--- Returns the instance type of the player.
--- @return integer
function Player:GetInstanceType() end

--- Returns the race ID of the player (e.g., Warrior M/F, Ninja M/F).
--- @return integer
function Player:GetRace() end

-- ==========================================================
-- 2. Status & Attributes
-- ==========================================================

--- Returns a specific status point value.
--- @param pointType integer The status type ID (e.g., MAX_HP, STR, DEX).
--- @return integer
function Player:GetStatus(pointType) end

--- Returns the current Health Points (HP).
--- @return integer
function Player:GetHP() end

--- Returns the maximum Health Points (Max HP).
--- @return integer
function Player:GetMaxHP() end

--- Returns the current Mana Points (MP).
--- @return integer
function Player:GetMana() end

--- Returns the maximum Mana Points (MP).
--- @return integer
function Player:GetMaxMana() end

--- Returns the current level.
--- @return integer
function Player:GetLevel() end

--- Returns the current experience points.
--- @return integer
function Player:GetExp() end

--- Returns the experience required for the next level.
--- @return integer
function Player:GetNextExp() end

-- ==========================================================
-- 3. State Booleans
-- ==========================================================

--- @return boolean
function Player:IsDead() end

--- @return boolean
function Player:IsStunned() end

--- @return boolean
function Player:IsWaiting() end

--- @return boolean
function Player:IsWalking() end

--- @return boolean
function Player:IsAttacking() end

--- @return boolean
function Player:IsAttacked() end

--- @return boolean
function Player:IsUsingSkill() end

--- @return boolean
function Player:IsMountingHorse() end

-- ==========================================================
-- 4. Position & Movement
-- ==========================================================

--- Returns the current global position.
--- @return Vector3
function Player:GetPosition() end

--- Teleports the player locally to the specified position.
--- Note: This is client-side only and may cause rubber-banding if not handled correctly.
--- @param position Vector3
function Player:SetLocalPosition(position) end

--- Moves the player to the target position using the game's pathfinding/movement logic.
--- @param position Vector3
function Player:MoveToPosition(position) end

--- Returns the character's body rotation.
--- @return number
function Player:GetRotation() end

--- Returns the camera's current rotation angle.
--- @return number
function Player:GetCameraRotation() end

--- Sets the character's body rotation.
--- @param rotation number
function Player:SetRotation(rotation) end

--- Rotates the character to face a specific target position.
--- @param position Vector3
function Player:LookAtPosition(position) end

--- Sets the movement speed (client-side).
--- @param speed integer
function Player:SetMoveSpeed(speed) end

-- ==========================================================
-- 5. Combat & Skills
-- ==========================================================

--- @return integer
function Player:GetWeaponType() end

--- @param comboType integer
function Player:SetComboType(comboType) end

--- @param attackSpeed integer
function Player:SetAttackSpeed(attackSpeed) end

--- Returns the current combo index of the player.
--- @return integer
function Player:GetComboIndex() end

--- Simulates holding or releasing the attack key (Spacebar).
--- @param isPressed boolean True to hold attack, False to release.
function Player:SetAttackKeyState(isPressed) end

--- Checks if a specific skill is currently active (e.g., Aura of Sword).
--- @param skillIndex integer The skill slot index or ID.
--- @return boolean
function Player:IsSkillActive(skillIndex) end

--- Checks if a skill is currently on cooldown.
--- @param skillIndex integer The skill slot index or ID.
--- @return boolean
function Player:IsSkillOnCooldown(skillIndex) end

--- Returns the remaining cooldown time for a skill in seconds.
--- @param skillIndex integer The skill slot index or ID.
--- @return number The remaining cooldown time in seconds (0.0 if not on cooldown).
function Player:GetSkillCoolTime(skillIndex) end

--- Triggers the use of a skill.
--- @param skillIndex integer The skill slot index or ID.
function Player:UseSkill(skillIndex) end

--- Returns the VID of the currently selected target.
--- Returns 0 if no target is selected.
--- @return integer
function Player:GetTargetVID() end

--- Simulates clicking on an actor (Monster/NPC/Player).
--- @param targetVID integer The VID of the target.
--- @param isAuto boolean Whether this is an auto-attack click.
function Player:OnPressActor(targetVID, isAuto) end

-- ==========================================================
-- 6. Visuals & Affects
-- ==========================================================

--- Toggles a visual affect on the player.
--- @param index integer The affect index.
--- @param isVisible boolean
function Player:SetAffect(index, isVisible) end

--- Checks if the player has a specific affect active.
--- @param index integer The affect index.
--- @return boolean
function Player:HasAffect(index) end

--- Spawns a client-side visual effect at the target position.
--- @param fileName string The path to the effect file (.mse).
--- @param targetPos Vector3
function Player:CreateEffect(fileName, targetPos) end

-- ==========================================================
-- 7. Items
-- ==========================================================

--- Attempts to pick up the nearest item on the ground.
function Player:PickCloseItem() end

-- ==========================================================
-- 8. Interaction & Misc
-- ==========================================================

--- Sends a packet to restart/revive at the current position.
function Player:Revive() end

--- Mounts the horse if available.
function Player:MountHorse() end

--- Dismounts the horse.
function Player:DismountHorse() end

--- Sends the fishing action packet (cast rod or pull).
function Player:SendFishing() end


--[[----------------------------------------------------------------------------
    EntityManager
    Defined in: Implementations/Entities/EntityManager.h
    Bound in: LuaPlugin::RegisterGameManagerBindings
----------------------------------------------------------------------------]]

--- @class EntityManager
EntityManager = {}

--- Retrieves a specific entity by its runtime Virtual ID (VID).
--- @param virtualID integer The unique runtime ID of the entity.
--- @return Entity|nil @Returns nil if the entity is not found.
function EntityManager:GetEntity(virtualID) end

--- Returns a list of all entities that satisfy a specific condition.
--- @param conditionFun fun(e: Entity): boolean A callback function that returns true to include the entity.
--- @return Entity[]
function EntityManager:GetEntities(conditionFun) end

--- Finds the nearest entity with a specific VNUM.
--- @param center Vector3 The search origin.
--- @param vnum integer The Virtual Number (ID) to search for.
--- @param range? number The maximum search radius.
--- @return Entity|nil
function EntityManager:GetClosestEntityByVNUM(center, vnum, range) end

-- ==========================================================
-- Mobs (Monsters)
-- ==========================================================

--- Counts how many mobs are within the specified range.
--- @param center Vector3
--- @param range number
--- @return integer
function EntityManager:GetMobCountInRange(center, range) end

--- Returns a list of all mobs within the specified range.
--- @param center Vector3
--- @param range number
--- @return Entity[]
function EntityManager:GetMobsAround(center, range) end

--- Finds the nearest mob to the center point.
--- @param center Vector3
--- @param range number
--- @return Entity|nil
function EntityManager:GetClosestMob(center, range) end

-- ==========================================================
-- Stones (Metins)
-- ==========================================================

--- Counts how many Metin stones are within the specified range.
--- @param center Vector3
--- @param range number
--- @return integer
function EntityManager:GetStoneCountInRange(center, range) end

--- Returns a list of all Metin stones within the specified range.
--- @param center Vector3
--- @param range number
--- @return Entity[]
function EntityManager:GetStonesAround(center, range) end

--- Finds the nearest Metin stone to the center point.
--- @param center Vector3
--- @param range number
--- @return Entity|nil
function EntityManager:GetClosestStone(center, range) end

-- ==========================================================
-- NPCs
-- ==========================================================

--- Counts how many NPCs are within the specified range.
--- @param center Vector3
--- @param range number
--- @return integer
function EntityManager:GetNpcCountInRange(center, range) end

--- Returns a list of all NPCs within the specified range.
--- @param center Vector3
--- @param range number
--- @return Entity[]
function EntityManager:GetNpcsAround(center, range) end

--- Finds the nearest NPC to the center point.
--- @param center Vector3
--- @param range number
--- @return Entity|nil
function EntityManager:GetClosestNPC(center, range) end

-- ==========================================================
-- Players
-- ==========================================================

--- Counts how many players are within the specified range.
--- @param center Vector3
--- @param range number
--- @param includeOwn? boolean Whether to include the local player in the count.
--- @return integer
function EntityManager:GetPlayerCountInRange(center, range, includeOwn) end

--- Returns a list of all players within the specified range.
--- @param center Vector3
--- @param range number
--- @param includeOwn? boolean Whether to include the local player in the list.
--- @return Player[]
function EntityManager:GetPlayersAround(center, range, includeOwn) end

--- Finds the nearest player to the center point.
--- @param center Vector3
--- @param range number
--- @return Player|nil
function EntityManager:GetClosestPlayer(center, range) end


--[[----------------------------------------------------------------------------
    NetworkManager
    Defined in: Implementations/Network/NetworkManager.h
    Bound in: LuaPlugin::RegisterGameManagerBindings
----------------------------------------------------------------------------]]

--- @class NetworkManager
NetworkManager = {}

-- 1. Connection & Core

--- Initiates a connection to the game server.
function NetworkManager:ConnectGameServer() end

--- Sends a raw packet to the server.
--- Warning: Advanced use only. Incorrect usage may disconnect the client.
--- @param data string The raw byte data.
function NetworkManager:SendPacket(data) end

--- Returns the current network phase (e.g., "Game", "Login", "Handshake").
--- @return string
function NetworkManager:GetCurrentPhase() end

--- Sends authentication credentials to the server.
--- @param login string
--- @param password string
--- @param pin? string (Optional) Character PIN.
--- @param channel? number (Optional) Channel number - defaults to 1
function NetworkManager:SendLoginPacket(login, password, pin, channel) end

--- Switches to a different game channel.
--- @param channel number The channel number to switch to.
function NetworkManager:SwitchChannel(channel) end

--- Connects directly to a specific port (for advanced use/exploits).
--- @param port number The port number to connect to.
function NetworkManager:ConnectToPort(port) end

--- Returns the current channel number derived from the last connected port.
--- Returns 0 if no connection has been made yet.
--- @return integer
function NetworkManager:GetCurrentChannel() end

-- 2. Inventory & Items

--- Sends a packet to move an item within the inventory.
--- @param fromCell integer Source slot index.
--- @param toCell integer Destination slot index.
--- @param count integer Amount to move.
function NetworkManager:SendItemMovePacket(fromCell, toCell, count) end

--- Sends a packet to give/trade an item to another entity.
--- @param fromCell integer Source slot index.
--- @param targetVID integer The VID of the recipient.
--- @param count integer Amount to give.
function NetworkManager:SendGiveItemPacket(fromCell, targetVID, count) end

--- Sends a packet to use (consume/equip) an item.
--- @param cell integer The inventory slot index.
function NetworkManager:SendItemUsePacket(cell) end

--- Sends a packet to move an item within the safebox/warehouse.
--- @param bySourcePos integer Source slot index in the safebox.
--- @param byTargetPos integer Destination slot index in the safebox.
--- @param byCount integer Amount to move.
function NetworkManager:SendSafeBoxItemMovePacket(bySourcePos, byTargetPos, byCount) end

-- 3. Shop (NPC)

--- Sends a packet to buy an item from an open NPC shop.
--- @param shopSlotIndex integer The slot index in the shop window.
function NetworkManager:SendShopBuyPacket(shopSlotIndex) end

--- Sends a packet to sell an item to an NPC.
--- @param inventorySlotIndex integer The slot index in your inventory.
--- @param count integer Amount to sell.
function NetworkManager:SendShopSellPacket(inventorySlotIndex, count) end

--- Sends a packet to close the current shop window.
function NetworkManager:SendShopEndPacket() end

-- 4. Exchange (Trade)

--- Sends a request to start a trade with another player.
--- @param targetVID integer The VID of the target player.
function NetworkManager:SendExchangeStartPacket(targetVID) end

--- Sends a packet accepting the current trade offer.
function NetworkManager:SendExchangeAcceptPacket() end

--- Sends a packet cancelling/closing the trade.
function NetworkManager:SendExchangeExitPacket() end

--- Adds Yang (currency) to the trade window.
--- @param yangAmount integer
function NetworkManager:SendExchangeYangAddPacket(yangAmount) end

--- Adds an item to the trade window.
--- @param inventorySlotIndex integer Source inventory slot.
--- @param targetSlotIndex integer Destination slot in the trade window.
function NetworkManager:SendExchangeItemAddPacket(inventorySlotIndex, targetSlotIndex) end

-- 5. Chat & Social

--- Sends a standard chat packet.
--- @param message string
--- @param chatType integer (0=Normal, 1=Shout, 2=Guild, etc.)
function NetworkManager:SendChatPacket(message, chatType) end

--- Sends a whisper packet.
--- @param targetName string The character name to whisper.
--- @param message string
function NetworkManager:SendWhisperPacket(targetName, message) end

-- 6. Interaction, Movement & State

--- Sends a click packet (selecting a target).
--- @param targetVID integer
function NetworkManager:SendOnClickPacket(targetVID) end

--- Sends an attack packet.
--- @param motionType integer The animation/attack type ID.
--- @param victimVID integer The VID of the target being hit.
function NetworkManager:SendAttackPacket(motionType, victimVID) end

--- Sends a character state update (movement/action).
--- @param destination Vector3 Target coordinates.
--- @param rotation number Character rotation.
--- @param eFunc integer Function type (e.g., Move, Stop).
--- @param uArg integer Argument for the function.
function NetworkManager:SendCharacterStatePacket(destination, rotation, eFunc, uArg) end

--- Sends a position synchronization packet.
--- @param vid integer Entity VID.
--- @param posX integer Global X.
--- @param posY integer Global Y.
function NetworkManager:SendSyncPositionPacket(vid, posX, posY) end

--- Sends a response to a quest/script dialog.
--- @param answerIndex integer The index of the selected option.
function NetworkManager:SendScriptAnswerPacket(answerIndex) end

-- 7. Guild

--- Sends a packet to donate experience to the guild.
--- @param experience integer Amount of EXP to donate.
function NetworkManager:SendGuildGiveExperiencePacket(experience) end


--[[----------------------------------------------------------------------------
    ChatManager
    Defined in: Implementations/Chat/ChatManager.h
    Bound in: LuaPlugin::RegisterGameManagerBindings
----------------------------------------------------------------------------]]

--- @class ChatManager
ChatManager = {}

--- Sends a chat message via the game's internal chat handler.
--- @param message string
--- @param chatType integer
function ChatManager:SendChat(message, chatType) end

--- Sends a whisper via the game's internal handler.
--- @param targetName string
--- @param message string
function ChatManager:SendWhisper(targetName, message) end


--[[----------------------------------------------------------------------------
    ExchangeManager
    Defined in: Implementations/Exchange/ExchangeManager.h
    Bound in: LuaPlugin::RegisterManagerBindings
----------------------------------------------------------------------------]]

--- @class ExchangeManager
ExchangeManager = {}

--- Checks if a trade window is currently open.
--- @return boolean
function ExchangeManager:IsTrading() end

--- Initiates a trade with a player.
--- @param targetVID integer
function ExchangeManager:StartTrade(targetVID) end

--- Accepts the current trade (locks in).
function ExchangeManager:AcceptTrade() end

--- Cancels the current trade.
function ExchangeManager:ExitTrade() end

--- Adds an item to the current trade window.
--- @param itemCell integer Inventory slot of the item.
--- @param exchangeWindowSlotIndex integer Slot in the trade window (0-11).
function ExchangeManager:AddItem(itemCell, exchangeWindowSlotIndex) end

--- Adds Yang to the current trade.
--- @param yangAmount integer
function ExchangeManager:AddYang(yangAmount) end

--- Returns the name of the trade partner.
function ExchangeManager:GetPartnerName() end

--- Returns whether or not the trade has been accepted by partenr yet.
function ExchangeManager:GetAcceptFromPartner() end


--[[----------------------------------------------------------------------------
    InventoryManager
    Defined in: Implementations/Inventory/InventoryManager.h
    Bound in: LuaPlugin::RegisterManagerBindings
----------------------------------------------------------------------------]]

--- @class InventoryManager
InventoryManager = {}

-- Actions

--- Uses or equips an item at the specified cell.
--- @param itemCell integer
function InventoryManager:UseItem(itemCell) end

--- Moves an item from one cell to another.
--- @param fromCell integer
--- @param toCell integer
--- @param count integer
function InventoryManager:MoveItem(fromCell, toCell, count) end

--- Drops or gives an item to a target (if targetVID is valid).
--- @param fromCell integer
--- @param targetVID integer
--- @param count integer
function InventoryManager:GiveItem(fromCell, targetVID, count) end

-- Data Access

--- Retrieves a specific attribute (bonus) from an item.
--- @param window integer Inventory window type (Inventory, Equipment, etc).
--- @param cell integer Slot index.
--- @param attrIndex integer Attribute index (0-6).
--- @return integer attributeType, integer attributeValue
function InventoryManager:GetItemAttribute(window, cell, attrIndex) end

--- Gets the VNUM (Item ID) of an item in a specific cell.
--- @param window integer
--- @param cell integer
--- @return integer
function InventoryManager:GetItemVNUM(window, cell) end

--- Gets the stack count of an item.
--- @param window integer
--- @param cell integer
--- @return integer
function InventoryManager:GetItemCount(window, cell) end

--- Gets the value of a socket (stone/spirit stone) on the item.
--- @param cell integer
--- @param socketIndex integer (0-2 usually).
--- @return integer
function InventoryManager:GetItemSocket(cell, socketIndex) end

-- Helpers / Search

--- Finds the first inventory cell containing the specified item VNUM.
--- @param vnum integer
--- @return integer @Returns -1 if not found.
function InventoryManager:FindItemCell(vnum) end

--- Finds the first empty cell in the inventory.
--- @return integer @Returns -1 if full.
function InventoryManager:FindEmptyCell() end


--[[----------------------------------------------------------------------------
    GroundItem
    Defined in: Implementations/GroundItem/GroundItem.h
    Bound in: LuaPlugin::RegisterManagerBindings
----------------------------------------------------------------------------]]

--- @class GroundItem
GroundItem = {}

--- Returns the unique ID of the ground item.
--- @return integer
function GroundItem:GetID() end

--- Returns the VNUM (Item ID) of the ground item.
--- @return integer
function GroundItem:GetVirtualNumber() end

--- Returns the name of the item.
--- @return string
function GroundItem:GetName() end

--- Returns the name of the player who owns the drop (if any).
--- @return string
function GroundItem:GetOwnerName() end

--- Returns the position of the item on the ground.
--- @return Vector3
function GroundItem:GetPosition() end


--[[----------------------------------------------------------------------------
    GroundItemManager
    Defined in: Implementations/GroundItem/GroundItemManager.h
    Bound in: LuaPlugin::RegisterManagerBindings
----------------------------------------------------------------------------]]

--- @class GroundItemManager
GroundItemManager = {}

--- Returns a list of all items currently on the ground.
--- @return GroundItem[]
function GroundItemManager:GetItems() end

--- Returns the total count of items on the ground.
--- @return integer
function GroundItemManager:GetItemsCount() end

--- Returns a list of items that can be picked up (e.g., owned by you or free).
--- @return GroundItem[]
function GroundItemManager:GetPickableItems() end

--- Returns the count of pickable items.
--- @return integer
function GroundItemManager:GetPickableItemsCount() end


--[[----------------------------------------------------------------------------
    ShopManager
    Defined in: Implementations/Shop/ShopManager.h
    Bound in: LuaPlugin::RegisterManagerBindings
----------------------------------------------------------------------------]]

--- @class ShopManager
ShopManager = {}

--- Gets a list of nearby shop VIDs within the specified range.
--- @param range number Maximum distance to scan for shops.
--- @return integer[] List of shop VIDs.
function ShopManager:GetNearbyShops(range) end

--- Opens a shop by sending the open packet.
--- @param vid integer The shop VID to open.
--- @return boolean True if packet was sent successfully.
function ShopManager:OpenShop(vid) end

--- Checks if shop data is available (packet received and parsed).
--- More reliable than checking if shop UI is open.
--- @return boolean True if shop data is cached and ready to read.
function ShopManager:HasShopData() end

--- Buys an item from a player shop by sending the buy packet.
--- @param shopVid integer The VID of the shop to buy from.
--- @param displayPos integer The display slot position of the item in the shop.
--- @return boolean True if the packet was sent successfully.
function ShopManager:BuyFromShop(shopVid, displayPos) end

--- Gets the current cached shop's item data.
--- @return table[] Array of shop items with fields: vnum, count, won, yang, name, slot.
function ShopManager:GetCurrentShopData() end

--- Clears the cached shop data after reading it.
--- Call this after collecting data to prepare for the next shop.
function ShopManager:ClearCurrentShopData() end

--- Collects shop data for later processing/sending.
--- @param shopVid integer The shop VID.
--- @param shopData table[] The shop item data.
function ShopManager:CollectShopData(shopVid, shopData) end

--- Exports all collected shop data as JSON.
--- @return table JSON object with shops, unique_items, and stats.
function ShopManager:ExportCollectedData() end

--- Sends all collected data to the API server.
function ShopManager:SendToAPI() end

--- Clears all collected shop data.
function ShopManager:ClearCollectedData() end

--- Gets the number of shops collected so far.
--- @return integer
function ShopManager:GetCollectedShopsCount() end

--- Gets the number of unique items found.
--- @return integer
function ShopManager:GetUniqueItemsCount() end


--[[----------------------------------------------------------------------------
    MapManager
    Defined in: Implementations/Map/MapManager.h
    Bound in: LuaPlugin::RegisterManagerBindings
----------------------------------------------------------------------------]]

--- @class MapManager
MapManager = {}

--- Returns the name of the current map.
--- @return string
function MapManager:GetCurrentMapName() end

--- Checks if a specific coordinate is blocked (collision/wall).
--- @param position Vector3
--- @return boolean
function MapManager:IsPositionBlocked(position) end

--- Returns the height at a specific position (includes terrain + objects).
--- @param position Vector3
--- @return number
function MapManager:GetPositionHeight(position) end

--- Returns the terrain height at a specific position (terrain only, no objects).
--- @param position Vector3
--- @return number
function MapManager:GetTerrainHeight(position) end


--[[----------------------------------------------------------------------------
    PathFinder
    Defined in: Implementations/Navigation/PathFinder.h
    Bound in: LuaPlugin::RegisterManagerBindings
----------------------------------------------------------------------------]]

--- @class PathFinder
PathFinder = {}

--- Calculates a walkable path between two points.
--- @param startPos Vector3
--- @param endPos Vector3
--- @return Vector3[] @Returns a list of Vector3 waypoints.
function PathFinder:CalculatePath(startPos, endPos) end

--- Checks if a straight line path between two points is safe (no obstacles).
--- Useful for local pathing around mobs without full pathfinding.
--- @param startPos Vector3
--- @param endPos Vector3
--- @return boolean @Returns true if the path is clear, false if blocked.
function PathFinder:IsPathSafe(startPos, endPos) end


--[[----------------------------------------------------------------------------
    InputManager
    Defined in: Implementations/Input/InputManager.h
    Bound in: LuaPlugin::RegisterUtilityManagerBindings
----------------------------------------------------------------------------]]

--- @enum InputScope
InputScope = {
    Window = 0, -- Only detects input when the game window is active.
    Global = 1  -- Detects input system-wide (even if backgrounded).
}

--- @class InputManager
InputManager = {}

--- Checks if a key was pressed in this frame (single click).
--- Returns true only on the frame the key was initially pressed.
--- Accepts either a plain VK code or a packed hotkey value from AddHotkey fields.
--- Packed format: (modMask << 8) | vkCode — modifier keys are checked automatically.
--- @param vkCode integer Plain VK code (e.g. 0x74) or packed hotkey from plugin.settings.
--- @param scope? InputScope (Optional) Defaults to InputScope.Window.
--- @return boolean
function InputManager:IsKeyPressed(vkCode, scope) end

--- Checks if a key is currently held down.
--- Returns true every frame the key remains down.
--- Accepts either a plain VK code or a packed hotkey value from AddHotkey fields.
--- @param vkCode integer Plain VK code or packed hotkey from plugin.settings.
--- @param scope? InputScope (Optional) Defaults to InputScope.Window.
--- @return boolean
function InputManager:IsKeyDown(vkCode, scope) end

--- Checks if a key was released in this frame.
--- Returns true only on the frame the key was let go.
--- Accepts either a plain VK code or a packed hotkey value from AddHotkey fields.
--- @param vkCode integer Plain VK code or packed hotkey from plugin.settings.
--- @param scope? InputScope (Optional) Defaults to InputScope.Window.
--- @return boolean
function InputManager:IsKeyReleased(vkCode, scope) end


--[[----------------------------------------------------------------------------
    ActionManager
    Defined in: Implementations/Actions/ActionManager.h
    Bound in: LuaPlugin::RegisterUtilityManagerBindings
----------------------------------------------------------------------------]]

--- @class ActionManager
ActionManager = {}

--- Starts a beep sound with specified duration and frequency.
--- @param durationMs integer Duration in milliseconds.
--- @param frequencyHz integer Frequency in Hertz (e.g., 1000).
function ActionManager:Beep(durationMs, frequencyHz) end

--- Plays a .wav sound file the specified amount of times.
--- @param soundFile string Path to the file.
--- @param count integer Number of times to play.
function ActionManager:PlaySound(soundFile, count) end


--[[----------------------------------------------------------------------------
    ProxyManager
    Defined in: Implementations/Proxy/ProxyManager.h
    Bound in: LuaPlugin::RegisterUtilityManagerBindings
----------------------------------------------------------------------------]]

--- @class ProxyManager
ProxyManager = {}

--- Enables the proxy connection.
function ProxyManager:Enable() end

--- Disables the proxy connection.
function ProxyManager:Disable() end

--- Checks if the proxy is currently enabled.
--- @return boolean
function ProxyManager:IsEnabled() end

--- Sets the proxy configuration.
--- @param host string Proxy IP or Hostname.
--- @param port integer Proxy Port.
--- @param username? string (Optional) Auth Username.
--- @param password? string (Optional) Auth Password.
function ProxyManager:SetProxyDetails(host, port, username, password) end


--[[----------------------------------------------------------------------------
    HwidManager
    Defined in: Implementations/Hwid/HwidManager.h
    Bound in: LuaPlugin::RegisterUtilityManagerBindings
----------------------------------------------------------------------------]]

--- @class HwidManager
HwidManager = {}

--- Enables the HWND/HWID spoofer to mask device identity.
function HwidManager:EnableSpoofer() end


--[[----------------------------------------------------------------------------
    MenuManager
    Defined in: HoodieSDK/Plugin/IMenuManager.h
    Bound in: LuaPlugin::RegisterCustomLuaFunctions
----------------------------------------------------------------------------]]

--- @class MenuManager
MenuManager = {}

--- Starts a new visual section in the menu.
--- @param title string
--- @param options? table Optional: { visibleIf = { field = "fieldId", value = true } }
function MenuManager:BeginSection(title, options) end

--- Ends the current visual section.
function MenuManager:EndSection() end

--- Adds a checkbox toggle.
--- @param id string Unique identifier for saving config.
--- @param label string Display text.
--- @param options? table Optional: { visibleIf = { field = "fieldId", value = true } }
function MenuManager:AddCheckbox(id, label, options) end

--- Adds a slider for numeric values.
--- @param id string Unique identifier.
--- @param label string Display text.
--- @param min number Minimum value.
--- @param max number Maximum value.
--- @param options? table Optional: { visibleIf = { field = "fieldId", value = "someValue" } }
function MenuManager:AddSlider(id, label, min, max, options) end

--- Adds a text input field.
--- @param id string Unique identifier.
--- @param label string Display text.
--- @param options? table Optional: { visibleIf = { field = "fieldId", value = true } }
function MenuManager:AddTextInput(id, label, options) end

--- Adds a number input field.
--- @param id string Unique identifier.
--- @param label string Display text.
--- @param min? number Default 0.
--- @param max? number Default 100.
--- @param options? table Optional: { visibleIf = { field = "fieldId", value = true } }
function MenuManager:AddNumberInput(id, label, min, max, options) end

--- Adds a dropdown combobox.
--- @param id string Unique identifier.
--- @param label string Display text.
--- @param options string[] A list of string options.
--- @param opts? table Optional: { visibleIf = { field = "fieldId", value = "Sound" } }
function MenuManager:AddCombobox(id, label, options, opts) end

--- Adds a clickable button.
--- @param label string Button text displayed on the UI.
--- @param functionName string Name of the Lua function to call when clicked.
--- @param options? table Optional: { description = "tooltip text", visibleIf = { field = "fieldId", value = true } }
function MenuManager:AddButton(label, functionName, options) end

--- Adds a listbox for managing string arrays.
--- @param id string Unique identifier.
--- @param label string Display text.
--- @param options? table Optional: { placeholder = "Enter item..." }
function MenuManager:AddListBox(id, label, options) end

--- Adds a hotkey picker field.
--- The value stored in plugin.settings[id] is a packed integer:
---   (modMask << 8) | vkCode
--- where modMask bits are: 0x01=Ctrl, 0x02=Alt, 0x04=Shift
--- Use Hotkey.Unpack() or Hotkey.IsPressed() to work with the value.
--- @param id string Unique identifier.
--- @param label string Display text.
--- @param options? table Optional: { visibleIf = { field = "fieldId", value = true } }
function MenuManager:AddHotkey(id, label, options) end

--- Adds an item picker field (searchable item vnum selector).
--- The value stored in plugin.settings[id] is the selected item vnum as an integer.
--- @param id string Unique identifier.
--- @param label string Display text.
--- @param options? table Optional: { placeholder = "Search items...", visibleIf = { field = "fieldId", value = true } }
function MenuManager:AddItemPicker(id, label, options) end

--- Adds a mob picker field (searchable mob vnum selector).
--- The value stored in plugin.settings[id] is the selected mob vnum as an integer.
--- @param id string Unique identifier.
--- @param label string Display text.
--- @param options? table Optional: { placeholder = "Search mobs...", visibleIf = { field = "fieldId", value = true } }
function MenuManager:AddMobPicker(id, label, options) end

--- Adds a table with multiple columns (returns TableBuilder for chaining).
--- @param id string Unique identifier.
--- @param label string Display text.
--- @param options? table Optional: { visibleIf = { field = "fieldId", value = true } }
--- @return TableBuilder
function MenuManager:AddTable(id, label, options) end


--[[----------------------------------------------------------------------------
    TableBuilder
    Defined in: Implementations/Menu/MenuManager.h
    Bound in: LuaPlugin::RegisterCustomLuaFunctions
----------------------------------------------------------------------------]]

--- @class TableBuilder
TableBuilder = {}

--- @class NumberColumnOptions
--- @field step? number Step increment (default: 1)

--- @class SliderColumnOptions
--- @field step? number Step increment (default: 1)

--- Adds a number input column.
--- @param id string Column identifier.
--- @param label string Display label.
--- @param min number Minimum value.
--- @param max number Maximum value.
--- @param options? NumberColumnOptions Optional settings.
--- @return TableBuilder
function TableBuilder:AddNumberColumn(id, label, min, max, options) end

--- Adds a slider column.
--- @param id string Column identifier.
--- @param label string Display label.
--- @param min number Minimum value.
--- @param max number Maximum value.
--- @param options? SliderColumnOptions Optional settings.
--- @return TableBuilder
function TableBuilder:AddSliderColumn(id, label, min, max, options) end

--- Adds a checkbox column.
--- @param id string Column identifier.
--- @param label string Display label.
--- @return TableBuilder
function TableBuilder:AddCheckboxColumn(id, label) end

--- Adds a text input column.
--- @param id string Column identifier.
--- @param label string Display label.
--- @return TableBuilder
function TableBuilder:AddTextColumn(id, label) end

--- Adds a combobox column.
--- @param id string Column identifier.
--- @param label string Display label.
--- @param options string[] List of options.
--- @return TableBuilder
function TableBuilder:AddComboboxColumn(id, label, options) end

--- Adds an item picker column (searchable item vnum selector).
--- @param id string Column identifier.
--- @param label string Display label.
--- @return TableBuilder
function TableBuilder:AddItemPickerColumn(id, label) end

--- Adds a mob picker column (searchable mob vnum selector).
--- @param id string Column identifier.
--- @param label string Display label.
--- @return TableBuilder
function TableBuilder:AddMobPickerColumn(id, label) end

--- Sets a visibility condition on the table itself.
--- The table will only be shown when the specified field matches the given value.
--- @param condition { field: string, value: any }
--- @return TableBuilder
function TableBuilder:SetVisibility(condition) end


--[[----------------------------------------------------------------------------
    Global Functions & Script Callbacks
    Defined in: LuaPlugin.cpp
----------------------------------------------------------------------------]]

--- Custom print function that logs to the internal logger.
--- @param ... any
function print(...) end

--- @class PluginTable
--- @field name string
--- @field version string
--- @field author string
--- @field description string
plugin = {}

-- Callback definitions for the user to implement (Documentation only)

--- Called when the script is initialized.
--- @return boolean success
function Initialize() end

--- Called when the script is shutting down.
function Shutdown() end

--- Called to define the menu layout.
--- @param menu MenuManager
function SetupMenu(menu) end

-- Event Handlers

--- Triggered every render frame.
--- @param args AppUpdateEventArgs
function OnAppUpdate(args) end

--- Triggered every game logic tick.
--- @param args GameUpdateEventArgs
function OnGameUpdate(args) end

--- Triggered when the client is about to send a packet to the server.
--- Can be cancelled by calling args:PreventCall(true).
--- @param args SendPacketEventArgs
function OnSendPacket(args) end

--- Triggered when the client receives a packet from the server.
--- This event is read-only and cannot be cancelled.
--- @param args RecvPacketEventArgs
function OnRecvPacket(args) end

--- Triggered when the client syncs position with the server.
--- @param args SendSyncPositionPacketEventArgs
function OnSendSyncPositionPacket(args) end

--- Triggered when a chat message is received.
--- @param args AppendChatEventArgs
function OnAppendChat(args) end

--- Triggered when a whisper is received.
--- @param args AppendWhisperEventArgs
function OnAppendWhisper(args) end

--- Triggered when the client sends a chat packet.
--- @param args SendChatPacketEventArgs
function OnSendChatPacket(args) end

--- Triggered when a new map channel is loaded.
--- @param args OnChannelEventArgs
function OnChannelLoad(args) end

--- Triggered when a fishing effect occurs.
--- @param args FishingEffectEventArgs
function OnFishingEffect(args) end

--- Triggered when an emoticon is set on an instance.
--- @param args SetEmoticonEventArgs
function OnSetEmoticon(args) end

--[[----------------------------------------------------------------------------
    OnAPIRequest
    Triggered when the backend sends an "api-request" command to this bot.
    The event is dispatched to ALL enabled plugins — each plugin should check
    args.type and ignore requests it doesn't handle.

    To add a new request type:
      1. Define a @class for its payload below
      2. Add the type string to APIRequestType
      3. Add the payload class to APIRequestData
      4. Handle it in your plugin's OnAPIRequest

----------------------------------------------------------------------------]]

--[[----------------------------------------------------------------------------
    API Request Payload Types
    Add a new @class here for each new request type you introduce.
    The `data` field in APIRequestArgs will be typed accordingly.
----------------------------------------------------------------------------]]

--- @class MarketBuyRequestData
--- @field shopVid integer The VID of the private shop to buy from.
--- @field slotIndex integer The slot index within the shop (0-based).
--- @field vnum integer Expected item VNUM — validate before buying.
--- @field count integer How many to buy.
--- @field maxYang integer Maximum yang price willing to pay (sanity check).
--- @field shopPos Vector3|nil World position of the shop (nil if unknown).

--- @class MarketOpenRequestData
--- @field shopVid integer The VID of the private shop to open.
--- @field shopPos Vector3|nil World position of the shop (nil if unknown).

--- Union of all known request type strings.
--- Extend this when adding new request types.
--- @alias APIRequestType
--- | "market-buy"
--- | "market-open"

--- Union of all known request payload shapes.
--- Extend this when adding new request types.
--- @alias APIRequestData
--- | MarketBuyRequestData
--- | MarketOpenRequestData

--- @class APIRequestArgs
--- @field type APIRequestType   The request type discriminator.
--- @field requestId string      For ack correlation on the backend.
--- @field data APIRequestData   Payload — shape depends on type.

--- Triggered when the backend sends an api-request command to this bot.
--- Check args.type before handling — all plugins receive every request.
--- @param args APIRequestArgs
function OnAPIRequest(args) end


--[[----------------------------------------------------------------------------
    WindowManager
    Defined in: Implementations/Window/WindowManager.h
    Bound in: LuaPlugin::RegisterGameManagerBindings
----------------------------------------------------------------------------]]

--- @class WindowManager
WindowManager = {}

--- Simulates a key down event in the game window.
--- @param dikCode integer Windows Virtual Key Code (VK_*) (e.g., VK_F1 = 0x70, VK_SPACE = 0x20)
function WindowManager:RunKeyDown(dikCode) end

--- Simulates a key up event in the game window.
--- @param dikCode integer Windows Virtual Key Code (VK_*)
function WindowManager:RunKeyUp(dikCode) end

--- Simulates a left mouse button down event at the specified coordinates.
--- @param x integer X coordinate in screen space.
--- @param y integer Y coordinate in screen space.
function WindowManager:RunMouseLeftButtonDown(x, y) end

--- Simulates a left mouse button up event at the specified coordinates.
--- @param x integer X coordinate in screen space.
--- @param y integer Y coordinate in screen space.
function WindowManager:RunMouseLeftButtonUp(x, y) end

--- Simulates a right mouse button down event at the specified coordinates.
--- @param x integer X coordinate in screen space.
--- @param y integer Y coordinate in screen space.
function WindowManager:RunMouseRightButtonDown(x, y) end

--- Simulates a right mouse button up event at the specified coordinates.
--- @param x integer X coordinate in screen space.
--- @param y integer Y coordinate in screen space.
function WindowManager:RunMouseRightButtonUp(x, y) end

--- Unhides the game window if it was hidden.
function WindowManager:ShowWindow() end

--- Hides the game window from the screen and taskbar.
function WindowManager:HideWindow() end

--- Focuses the game window and brings it to the foreground.
--- This will steal input focus from other applications.
function WindowManager:FocusWindow() end

--- Brings the game window to the top of the screen WITHOUT stealing focus.
--- Useful for monitoring the game while typing in another window.
function WindowManager:BringWindowToFront() end

--- Moves the game window to the specified screen coordinates.
--- @param x integer X coordinate on the screen.
--- @param y integer Y coordinate on the screen.
function WindowManager:MoveWindow(x, y) end

--- Gets the current window position on the screen.
--- @return integer, integer Returns x and y coordinates as a pair.
function WindowManager:GetWindowPosition() end

--- Sets the title of the game window.
--- @param title string The new window title.
function WindowManager:SetTitle(title) end


--[[----------------------------------------------------------------------------
    RenderPass Enum
    Defined in: Implementations/Rendering/RenderManager.h
    Bound in: LuaPlugin::RegisterUtilityManagerBindings

    Determines at which point in the render pipeline a draw command is executed.
    - Deep: Rendered before the game's blend area (default). Drawn behind transparent/blended objects (water, fog).
    - Mid:  Rendered after the game's blend area. Drawn on top of blended objects — always visible over water/fog.
----------------------------------------------------------------------------]]

--- @enum RenderPass
RenderPass = {
    Deep = 0, -- Default. Rendered before blend area (may be hidden by water/fog).
    Mid  = 1, -- Rendered after blend area (always on top of water/fog).
}

--[[----------------------------------------------------------------------------
    DrawEffect Enum
    Defined in: Implementations/Rendering/RenderManager.h
    Bound in: LuaPlugin::RegisterUtilityManagerBindings

    Visual effect applied to a draw command. All effects are GPU-driven (pixel shaders).
    - None:    Standard rendering (glow line / radial gradient).
    - Pulse:   Breathing alpha animation — the shape smoothly fades in and out.
    - Dashed:  Animated marching-ants dashed pattern (lines/boxes only).
    - Rainbow: Hue cycles through the full spectrum over time.
----------------------------------------------------------------------------]]

--- @enum DrawEffect
DrawEffect = {
    None    = 0, -- Default. Standard glow rendering.
    Pulse   = 1, -- Breathing/pulsing alpha animation.
    Dashed  = 2, -- Animated dashed line pattern (marching ants). Best on lines/boxes.
    Rainbow = 3, -- Hue shifts through the color spectrum over time.
    Glow    = 4, -- Neon glow: bright core + soft additive bloom halo. Use glowIntensity to control.
}

--[[----------------------------------------------------------------------------
    RenderManager
    Defined in: Implementations/Rendering/RenderManager.h
    Bound in: LuaPlugin::RegisterUtilityManagerBindings
----------------------------------------------------------------------------]]

--- @class RenderManager
RenderManager = {}

--- Draws a 3D line in world space between two positions.
--- The line will be visible in the game world and affected by camera perspective.
--- @param startPos Vector3 Starting position in world coordinates.
--- @param endPos Vector3 Ending position in world coordinates.
--- @param color integer ARGB color value (e.g., 0xFFFF0000 for red, 0xFF00FF00 for green).
--- @param pass? RenderPass When to render (default: RenderPass.Deep).
--- @param effect? DrawEffect Visual effect (default: DrawEffect.None).
--- @param lineWidth? number Tube radius in world units (default: 2.0). Smaller = thinner lines.
--- @param glowIntensity? number Glow brightness for DrawEffect.Glow (default: 1.5). Higher = brighter neon.
--- @usage RenderManager:DrawLine3D(playerPos, targetPos, 0xFF00FF00)
--- @usage RenderManager:DrawLine3D(playerPos, targetPos, 0xFF00FF00, RenderPass.Mid, DrawEffect.Glow, 1.5, 2.0)
function RenderManager:DrawLine3D(startPos, endPos, color, pass, effect, lineWidth, glowIntensity) end

--- Draws a 3D circle in world space (horizontal plane).
--- The circle will be rendered as a filled radial gradient.
--- @param center Vector3 Center position in world coordinates.
--- @param radius number Radius of the circle in game units.
--- @param color integer ARGB color value (e.g., 0xFFFF0000 for red).
--- @param segments? integer Number of segments (default: 32). Higher = smoother but slower.
--- @param pass? RenderPass When to render (default: RenderPass.Deep).
--- @param effect? DrawEffect Visual effect (default: DrawEffect.None).
--- @usage RenderManager:DrawCircle3D(playerPos, 500, 0xFF00FF00, 64)
--- @usage RenderManager:DrawCircle3D(bossPos, 800, 0xFFFF0000, 48, RenderPass.Mid, DrawEffect.Rainbow)
function RenderManager:DrawCircle3D(center, radius, color, segments, pass, effect) end

--- Draws a 3D box (wireframe) in world space.
--- The box will be rendered as 12 lines connecting 8 corner points.
--- @param center Vector3 Center position in world coordinates.
--- @param size Vector3 Size of the box (width, depth, height).
--- @param color integer ARGB color value (e.g., 0xFFFF0000 for red).
--- @param throughWalls? boolean Whether the box is visible through walls (default: true).
--- @param pass? RenderPass When to render (default: RenderPass.Deep).
--- @param effect? DrawEffect Visual effect (default: DrawEffect.None).
--- @param lineWidth? number Tube radius for box edges (default: 2.0).
--- @param glowIntensity? number Glow brightness for DrawEffect.Glow (default: 1.5).
--- @usage RenderManager:DrawBox3D(entityPos, Vector3.new(100, 100, 200), 0xFF00FF00)
--- @usage RenderManager:DrawBox3D(entityPos, Vector3.new(100, 100, 200), 0xFF00FF00, true, RenderPass.Mid, DrawEffect.Glow, 1.0, 2.5)
function RenderManager:DrawBox3D(center, size, color, throughWalls, pass, effect, lineWidth, glowIntensity) end

--- Draws 2D text on the screen at fixed screen coordinates.
--- The text will always be visible regardless of camera position.
--- @param text string The text to display.
--- @param x integer Screen X coordinate in pixels (0 = left edge).
--- @param y integer Screen Y coordinate in pixels (0 = top edge).
--- @param color integer ARGB color value (e.g., 0xFFFFFFFF for white).
--- @param fontSize? integer Font size in pixels (default: 14).
--- @param pass? RenderPass When to render (default: RenderPass.Deep).
--- @usage RenderManager:DrawText2D("FPS: 60", 10, 10, 0xFFFFFFFF, 16)
function RenderManager:DrawText2D(text, x, y, color, fontSize, pass) end

--- Draws text at a 3D world position that automatically projects to screen space.
--- The text will move with the world position and disappear if behind the camera.
--- Perfect for entity labels, distance indicators, etc.
--- @param text string The text to display.
--- @param worldPos Vector3 Position in world coordinates.
--- @param color integer ARGB color value (e.g., 0xFFFF0000 for red).
--- @param fontSize? integer Font size in pixels (default: 14).
--- @param pass? RenderPass When to render (default: RenderPass.Deep).
--- @usage RenderManager:DrawText3D("Enemy", entityPos, 0xFFFF0000, 12)
--- @usage RenderManager:DrawText3D("Enemy", entityPos, 0xFFFF0000, 12, RenderPass.Mid)
function RenderManager:DrawText3D(text, worldPos, color, fontSize, pass) end

--- Converts a 3D world position to 2D screen coordinates.
--- Returns nil if the position is behind the camera or outside the viewport.
--- @param worldPos Vector3 Position in world coordinates.
--- @return table|nil Returns { x = number, y = number } or nil if not visible.
--- @usage local screen = RenderManager:WorldToScreen(entityPos)
---       if screen then print("Screen X:", screen.x, "Y:", screen.y) end
function RenderManager:WorldToScreen(worldPos) end

--- Clears all queued draw commands.
--- Normally called automatically each frame, but can be used to manually clear the queue.
--- @usage RenderManager:ClearDrawList()
function RenderManager:ClearDrawList() end


--[[----------------------------------------------------------------------------
    Color Constants & Helpers
    Common ARGB color values for convenience
----------------------------------------------------------------------------]]

--- @class Colors
--- Common ARGB color constants for easy use
Colors = {
    White = 0xFFFFFFFF,
    Black = 0xFF000000,
    Red = 0xFFFF0000,
    Green = 0xFF00FF00,
    Blue = 0xFF0000FF,
    Yellow = 0xFFFFFF00,
    Cyan = 0xFF00FFFF,
    Magenta = 0xFFFF00FF,
    Orange = 0xFFFF8800,
    Purple = 0xFF8800FF,
    Gray = 0xFF808080,
    LightGray = 0xFFC0C0C0,
    DarkGray = 0xFF404040,
}

--- Creates an ARGB color value from individual components.
--- @param a integer Alpha (transparency): 0 = fully transparent, 255 = fully opaque.
--- @param r integer Red component (0-255).
--- @param g integer Green component (0-255).
--- @param b integer Blue component (0-255).
--- @return integer ARGB color value.
--- @usage local semiTransparentRed = ARGB(128, 255, 0, 0)
function ARGB(a, r, g, b)
    return bit32.bor(
        bit32.lshift(a, 24),
        bit32.lshift(r, 16),
        bit32.lshift(g, 8),
        b
    )
end

--- Creates an RGB color value (fully opaque).
--- @param r integer Red component (0-255).
--- @param g integer Green component (0-255).
--- @param b integer Blue component (0-255).
--- @return integer ARGB color value with alpha = 255.
--- @usage local red = RGB(255, 0, 0)
function RGB(r, g, b)
    return ARGB(255, r, g, b)
end


--[[----------------------------------------------------------------------------
    CONDITIONAL VISIBILITY EXAMPLES
    
    Use visibleIf to show/hide fields based on other field values
----------------------------------------------------------------------------]]

--[[ EXAMPLE 1: Show field only when checkbox is enabled
function SetupMenu(menu)
    menu:BeginSection("Sound Settings")
    
    menu:AddCheckbox("enableSound", "Enable Sound Alerts")
    
    -- This field only shows when enableSound is true
    menu:AddTextInput("soundPath", "Sound File Path", {
        visibleIf = { field = "enableSound", value = true }
    })
    
    menu:EndSection()
end
]]

--[[ EXAMPLE 2: Show field based on combobox selection
function SetupMenu(menu)
    menu:BeginSection("Alert Settings")
    
    menu:AddCombobox("alertMode", "Alert Mode", {"Beep", "Sound"})
    
    -- This field only shows when alertMode is "Sound"
    menu:AddTextInput("soundFile", "Sound File", {
        visibleIf = { field = "alertMode", value = "Sound" }
    })
    
    -- This slider only shows when alertMode is "Sound"
    menu:AddSlider("volume", "Volume", 0, 100, {
        visibleIf = { field = "alertMode", value = "Sound" }
    })
    
    menu:EndSection()
end
]]

--[[ EXAMPLE 3: Multiple conditional fields
function SetupMenu(menu)
    menu:BeginSection("Advanced")
    
    menu:AddCheckbox("enableAdvanced", "Enable Advanced Options")
    
    -- All these fields only show when enableAdvanced is true
    menu:AddSlider("threshold", "Threshold", 0, 100, {
        visibleIf = { field = "enableAdvanced", value = true }
    })
    
    menu:AddTextInput("customScript", "Custom Script", {
        visibleIf = { field = "enableAdvanced", value = true }
    })
    
    menu:AddNumberInput("timeout", "Timeout (ms)", 100, 5000, {
        visibleIf = { field = "enableAdvanced", value = true }
    })
    
    menu:EndSection()
end
]]

--[[----------------------------------------------------------------------------
    Common Windows Virtual Key Codes (VK_*)
    Reference for use with InputManager.
----------------------------------------------------------------------------]]

--- @class VK
--- Common Windows Virtual Key Code constants.
VK = {
    -- Mouse
    LBUTTON  = 0x01, RBUTTON  = 0x02, MBUTTON  = 0x04,

    -- Control keys
    BACK     = 0x08, TAB      = 0x09, RETURN   = 0x0D,
    SHIFT    = 0x10, CONTROL  = 0x11, MENU     = 0x12, -- MENU = Alt
    PAUSE    = 0x13, CAPITAL  = 0x14, ESCAPE   = 0x1B,
    SPACE    = 0x20,

    -- Navigation
    PRIOR    = 0x21, NEXT     = 0x22, -- PageUp / PageDown
    END      = 0x23, HOME     = 0x24,
    LEFT     = 0x25, UP       = 0x26, RIGHT    = 0x27, DOWN     = 0x28,
    INSERT   = 0x2D, DELETE   = 0x2E,

    -- Digits
    D0 = 0x30, D1 = 0x31, D2 = 0x32, D3 = 0x33, D4 = 0x34,
    D5 = 0x35, D6 = 0x36, D7 = 0x37, D8 = 0x38, D9 = 0x39,

    -- Letters
    A = 0x41, B = 0x42, C = 0x43, D = 0x44, E = 0x45,
    F = 0x46, G = 0x47, H = 0x48, I = 0x49, J = 0x4A,
    K = 0x4B, L = 0x4C, M = 0x4D, N = 0x4E, O = 0x4F,
    P = 0x50, Q = 0x51, R = 0x52, S = 0x53, T = 0x54,
    U = 0x55, V = 0x56, W = 0x57, X = 0x58, Y = 0x59, Z = 0x5A,

    -- Numpad
    NUMPAD0 = 0x60, NUMPAD1 = 0x61, NUMPAD2 = 0x62, NUMPAD3 = 0x63,
    NUMPAD4 = 0x64, NUMPAD5 = 0x65, NUMPAD6 = 0x66, NUMPAD7 = 0x67,
    NUMPAD8 = 0x68, NUMPAD9 = 0x69,
    MULTIPLY = 0x6A, ADD = 0x6B, SUBTRACT = 0x6D, DECIMAL = 0x6E, DIVIDE = 0x6F,

    -- Function keys
    F1  = 0x70, F2  = 0x71, F3  = 0x72, F4  = 0x73,
    F5  = 0x74, F6  = 0x75, F7  = 0x76, F8  = 0x77,
    F9  = 0x78, F10 = 0x79, F11 = 0x7A, F12 = 0x7B,
}


--[[----------------------------------------------------------------------------
    Minimap
    Defined in: Internal/API/MinimapHandler.h
    Bound in: LuaPlugin::RegisterMinimapBindings

    Immediate-mode minimap overlay API — mirrors RenderManager style.
    Call Draw* functions every OnGameUpdate tick to keep shapes visible.
    Stop calling them and they disappear automatically — no cleanup needed.

    Coordinates are world-space (same units as Player:GetPosition()).
    Colors are CSS hex strings: "#rrggbb" or "#aarrggbb".
    Opacity values are 0.0–1.0.
----------------------------------------------------------------------------]]

--- @class Minimap
Minimap = {}

--- Draws a circle on the web minimap centered at a world position.
--- Call every tick to keep it visible. Stop calling to remove it.
--- @param pos Vector3 World position of the circle center (z is ignored).
--- @param radius number Radius in world units.
--- @param color? string CSS hex color string (default: "#3b82f6").
--- @param fillOpacity? number Fill opacity 0.0–1.0 (default: 0.08).
--- @param strokeOpacity? number Stroke/border opacity 0.0–1.0 (default: 0.7).
--- @usage Minimap:DrawCircle(pos, plugin.settings.range, "#ef4444", 0.05, 0.8)
function Minimap:DrawCircle(pos, radius, color, fillOpacity, strokeOpacity) end

--- Draws a marker dot on the web minimap at a world position.
--- Call every tick to keep it visible. Stop calling to remove it.
--- @param pos Vector3 World position (z is ignored).
--- @param label? string Optional text label shown next to the dot.
--- @param color? string CSS hex color string (default: "#f59e0b").
--- @param fillOpacity? number Fill opacity 0.0–1.0 (default: 0.9).
--- @param strokeOpacity? number Stroke opacity 0.0–1.0 (default: 1.0).
--- @usage Minimap:DrawMarker(targetPos, "Target", "#ef4444")
function Minimap:DrawMarker(pos, label, color, fillOpacity, strokeOpacity) end

--- Draws a text label on the web minimap at a world position.
--- Call every tick to keep it visible. Stop calling to remove it.
--- @param pos Vector3 World position (z is ignored).
--- @param text string The text to display.
--- @param color? string CSS hex color string (default: "#ffffff").
--- @usage Minimap:DrawText(pos, "Farm Zone", "#ffffff")
function Minimap:DrawText(pos, text, color) end

--- Draws a line segment on the web minimap between two world positions.
--- Call every tick to keep it visible. Stop calling to remove it.
--- For paths, call DrawLine once per segment in a loop.
--- @param from Vector3 Start position in world space (z is ignored).
--- @param to Vector3 End position in world space (z is ignored).
--- @param color? string CSS hex color string (default: "#f59e0b").
--- @param strokeOpacity? number Stroke opacity 0.0–1.0 (default: 0.8).
--- @usage
--- for i = 1, #waypoints - 1 do
---     Minimap:DrawLine(waypoints[i].pos, waypoints[i+1].pos, "#22c55e", 0.9)
--- end
function Minimap:DrawLine(from, to, color, strokeOpacity) end

--- Returns all waypoints for the current map, sorted by order index.
--- Waypoints are set from the web UI and pushed to the bot via socket.
--- Each waypoint is a table: { id, label, x, y, mapName, order }
--- @return table Array of waypoint tables sorted by order.
--- @usage
--- local waypoints = Minimap:GetWaypoints()
--- for _, wp in ipairs(waypoints) do
---     print(wp.order, wp.label, wp.x, wp.y)
--- end
function Minimap:GetWaypoints() end