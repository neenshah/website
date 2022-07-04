-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `steamID` VARCHAR(20) NULL,
    `alias` VARCHAR(64) NULL,
    `aliasLocked` BOOLEAN NULL DEFAULT false,
    `avatar` VARCHAR(255) NULL,
    `roles` INTEGER UNSIGNED NULL DEFAULT 0,
    `bans` INTEGER UNSIGNED NULL DEFAULT 0,
    `country` VARCHAR(2) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `user_steamID`(`steamID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Profile` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `bio` VARCHAR(1000) NULL DEFAULT '',
    `featuredBadgeID` INTEGER NULL,
    `userID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Profile_featuredBadgeID_key`(`featuredBadgeID`),
    UNIQUE INDEX `Profile_userID_key`(`userID`),
    INDEX `Profile_featuredBadgeID_userID_idx`(`featuredBadgeID`, `userID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UserStats` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `totalJumps` BIGINT UNSIGNED NULL DEFAULT 0,
    `totalStrafes` BIGINT UNSIGNED NULL DEFAULT 0,
    `level` SMALLINT UNSIGNED NULL DEFAULT 1,
    `cosXP` BIGINT UNSIGNED NULL DEFAULT 0,
    `mapsCompleted` INTEGER UNSIGNED NULL DEFAULT 0,
    `runsSubmitted` INTEGER UNSIGNED NULL DEFAULT 0,
    `userID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `UserStats_userID_key`(`userID`),
    INDEX `UserStats_userID_idx`(`userID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `DiscordAuth` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `discordID` VARCHAR(255) NULL,
    `displayName` VARCHAR(255) NULL,
    `accessToken` VARCHAR(255) NULL,
    `refreshToken` VARCHAR(255) NULL,
    `profileID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `DiscordAuth_profileID_key`(`profileID`),
    INDEX `DiscordAuth_profileID_idx`(`profileID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TwitchAuth` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `twitchID` INTEGER NULL,
    `displayName` VARCHAR(255) NULL,
    `token` VARCHAR(255) NULL,
    `profileID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `TwitchAuth_profileID_key`(`profileID`),
    INDEX `TwitchAuth_profileID_idx`(`profileID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TwitterAuth` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `twitterID` VARCHAR(255) NULL,
    `displayName` VARCHAR(255) NULL,
    `oauthKey` VARCHAR(255) NULL,
    `oauthSecret` VARCHAR(255) NULL,
    `profileID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `TwitterAuth_profileID_key`(`profileID`),
    INDEX `TwitterAuth_profileID_idx`(`profileID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Badge` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NULL,
    `description` VARCHAR(255) NULL,
    `image` VARCHAR(255) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UserBadges` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `badgeID` INTEGER NOT NULL,
    `userID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `UserBadges_badgeID_userID_idx`(`badgeID`, `userID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Activity` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `type` TINYINT NOT NULL DEFAULT 0,
    `data` BIGINT NOT NULL,
    `userID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `Activity_userID_idx`(`userID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Follow` (
    `notifyOn` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `followedID` INTEGER NOT NULL,
    `followeeID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `Follow_followeeID_followedID_idx`(`followeeID`, `followedID`),
    UNIQUE INDEX `follow_unique`(`followeeID`, `followedID`),
    PRIMARY KEY (`followeeID`, `followedID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Notification` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `read` BOOLEAN NOT NULL DEFAULT false,
    `userID` INTEGER NOT NULL,
    `activityID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `Notification_activityID_userID_idx`(`activityID`, `userID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Report` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `data` VARCHAR(255) NULL,
    `type` TINYINT UNSIGNED NULL,
    `category` SMALLINT UNSIGNED NULL,
    `message` VARCHAR(1000) NULL,
    `resolved` BOOLEAN NULL DEFAULT false,
    `resolutionMessage` VARCHAR(1000) NULL,
    `submitterID` INTEGER NULL,
    `resolverID` INTEGER NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `Report_resolverID_submitterID_idx`(`resolverID`, `submitterID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UserAuth` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `refreshToken` VARCHAR(255) NULL,
    `userID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `UserAuth_userID_key`(`userID`),
    INDEX `UserAuth_userID_idx`(`userID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Map` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    `type` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `statusFlag` TINYINT NOT NULL DEFAULT 2,
    `downloadURL` VARCHAR(255) NULL,
    `hash` CHAR(40) NULL,
    `thumbnailID` INTEGER NULL,
    `submitterID` INTEGER NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Map_thumbnailID_key`(`thumbnailID`),
    INDEX `Map_submitterID_idx`(`submitterID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MapCredit` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `type` TINYINT NOT NULL,
    `mapID` INTEGER NOT NULL,
    `userID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `MapCredit_mapID_userID_idx`(`mapID`, `userID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MapFavorite` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `mapID` INTEGER NOT NULL,
    `userID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `MapFavorite_mapID_userID_idx`(`mapID`, `userID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MapImage` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `small` VARCHAR(255) NULL,
    `medium` VARCHAR(255) NULL,
    `large` VARCHAR(255) NULL,
    `mapID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `MapImage_mapID_idx`(`mapID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MapInfo` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `description` VARCHAR(1000) NULL,
    `youtubeID` VARCHAR(11) NULL,
    `numTracks` TINYINT UNSIGNED NULL,
    `creationDate` DATETIME NOT NULL,
    `mapID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `MapInfo_mapID_key`(`mapID`),
    INDEX `MapInfo_mapID_idx`(`mapID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MapLibraryEntry` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userID` INTEGER NOT NULL,
    `mapID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `MapLibraryEntry_mapID_userID_idx`(`mapID`, `userID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MapNotify` (
    `notifyOn` TINYINT UNSIGNED NOT NULL,
    `mapID` INTEGER NOT NULL,
    `userID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `MapNotify_userID_mapID_idx`(`userID`, `mapID`),
    UNIQUE INDEX `mapnotify_unique`(`userID`, `mapID`),
    PRIMARY KEY (`userID`, `mapID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `UserMapRank` (
    `gameType` TINYINT UNSIGNED NOT NULL,
    `flags` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `trackNum` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `zoneNum` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `rank` INTEGER UNSIGNED NULL,
    `rankXP` INTEGER UNSIGNED NULL DEFAULT 0,
    `mapID` INTEGER NOT NULL,
    `userID` INTEGER NOT NULL,
    `runID` BIGINT NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `UserMapRank_runID_key`(`runID`),
    INDEX `UserMapRank_runID_userID_idx`(`runID`, `userID`),
    PRIMARY KEY (`mapID`, `userID`, `gameType`, `flags`, `trackNum`, `zoneNum`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MapReview` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `text` VARCHAR(1000) NOT NULL,
    `mapID` INTEGER NOT NULL,
    `reviewerID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `MapReview_mapID_reviewerID_idx`(`mapID`, `reviewerID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MapTrack` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `trackNum` TINYINT UNSIGNED NOT NULL,
    `numZones` TINYINT UNSIGNED NOT NULL,
    `isLinear` BOOLEAN NOT NULL,
    `difficulty` TINYINT UNSIGNED NOT NULL,
    `mapID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `MapTrack_mapID_idx`(`mapID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MapTrackStats` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `completions` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `uniqueCompletions` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `mapTrackID` INTEGER NOT NULL,
    `baseStatsID` BIGINT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `MapTrackStats_baseStatsID_key`(`baseStatsID`),
    INDEX `MapTrackStats_baseStatsID_mapTrackID_idx`(`baseStatsID`, `mapTrackID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MapZone` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `zoneNum` TINYINT UNSIGNED NOT NULL,
    `trackID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `MapZone_trackID_zoneNum_idx`(`trackID`, `zoneNum`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MapZoneTrigger` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `type` TINYINT UNSIGNED NOT NULL,
    `pointsHeight` FLOAT NOT NULL,
    `pointsZPos` FLOAT NOT NULL,
    `points` JSON NULL,
    `mapZoneID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `mapZoneID`(`mapZoneID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MapZoneTriggerProperties` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `properties` JSON NULL,
    `triggerID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `MapZoneTriggerProperties_triggerID_key`(`triggerID`),
    INDEX `triggerID`(`triggerID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MapZoneStats` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `completions` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `uniqueCompletions` INTEGER UNSIGNED NOT NULL DEFAULT 0,
    `zoneID` INTEGER NOT NULL,
    `baseStatsID` BIGINT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `MapZoneStats_baseStatsID_key`(`baseStatsID`),
    INDEX `MapZoneStats_baseStatsID_zoneID_idx`(`baseStatsID`, `zoneID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MapStats` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `reviews` INTEGER UNSIGNED NULL DEFAULT 0,
    `downloads` INTEGER UNSIGNED NULL DEFAULT 0,
    `subscriptions` INTEGER UNSIGNED NULL DEFAULT 0,
    `plays` INTEGER UNSIGNED NULL DEFAULT 0,
    `favorites` INTEGER UNSIGNED NULL DEFAULT 0,
    `completions` INTEGER UNSIGNED NULL DEFAULT 0,
    `uniqueCompletions` INTEGER UNSIGNED NULL DEFAULT 0,
    `timePlayed` BIGINT UNSIGNED NULL DEFAULT 0,
    `mapID` INTEGER NOT NULL,
    `baseStatsID` BIGINT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `MapStats_baseStatsID_key`(`baseStatsID`),
    INDEX `MapStats_baseStatsID_mapID_idx`(`baseStatsID`, `mapID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `BaseStats` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `jumps` INTEGER UNSIGNED NULL DEFAULT 0,
    `strafes` INTEGER UNSIGNED NULL DEFAULT 0,
    `avgStrafeSync` FLOAT NULL DEFAULT 0,
    `avgStrafeSync2` FLOAT NULL DEFAULT 0,
    `enterTime` FLOAT NULL DEFAULT 0,
    `totalTime` FLOAT NULL DEFAULT 0,
    `velAvg3D` FLOAT NULL DEFAULT 0,
    `velAvg2D` FLOAT NULL DEFAULT 0,
    `velMax3D` FLOAT NULL DEFAULT 0,
    `velMax2D` FLOAT NULL DEFAULT 0,
    `velEnter3D` FLOAT NULL DEFAULT 0,
    `velEnter2D` FLOAT NULL DEFAULT 0,
    `velExit3D` FLOAT NULL DEFAULT 0,
    `velExit2D` FLOAT NULL DEFAULT 0,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Run` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `trackNum` TINYINT UNSIGNED NOT NULL,
    `zoneNum` TINYINT UNSIGNED NOT NULL,
    `ticks` INTEGER UNSIGNED NOT NULL,
    `tickRate` FLOAT NOT NULL,
    `flags` INTEGER UNSIGNED NOT NULL,
    `file` VARCHAR(255) NOT NULL,
    `hash` VARCHAR(40) NOT NULL,
    `mapID` INTEGER NOT NULL,
    `playerID` INTEGER NULL,
    `baseStatsID` BIGINT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Run_baseStatsID_key`(`baseStatsID`),
    INDEX `Run_baseStatsID_mapID_playerID_flags_idx`(`baseStatsID`, `mapID`, `playerID`, `flags`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `RunZoneStats` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `zoneNum` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `runID` BIGINT NOT NULL,
    `baseStatsID` BIGINT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `RunZoneStats_baseStatsID_key`(`baseStatsID`),
    INDEX `RunZoneStats_baseStatsID_runID_idx`(`baseStatsID`, `runID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `RunSession` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `trackNum` TINYINT UNSIGNED NOT NULL,
    `zoneNum` TINYINT UNSIGNED NOT NULL,
    `userID` INTEGER NOT NULL,
    `trackID` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `RunSession_trackID_userID_idx`(`trackID`, `userID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `RunSessionTimestamp` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `zone` TINYINT UNSIGNED NOT NULL,
    `tick` INTEGER UNSIGNED NOT NULL,
    `sessionID` BIGINT NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `RunSessionTimestamp_sessionID_idx`(`sessionID`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `XpSystems` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `rankXP` JSON NULL,
    `cosXP` JSON NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Profile` ADD CONSTRAINT `Profile_userID_fkey` FOREIGN KEY (`userID`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Profile` ADD CONSTRAINT `Profile_featuredBadgeID_fkey` FOREIGN KEY (`featuredBadgeID`) REFERENCES `UserBadges`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserStats` ADD CONSTRAINT `UserStats_userID_fkey` FOREIGN KEY (`userID`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DiscordAuth` ADD CONSTRAINT `DiscordAuth_profileID_fkey` FOREIGN KEY (`profileID`) REFERENCES `Profile`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TwitchAuth` ADD CONSTRAINT `TwitchAuth_profileID_fkey` FOREIGN KEY (`profileID`) REFERENCES `Profile`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TwitterAuth` ADD CONSTRAINT `TwitterAuth_profileID_fkey` FOREIGN KEY (`profileID`) REFERENCES `Profile`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserBadges` ADD CONSTRAINT `UserBadges_userID_fkey` FOREIGN KEY (`userID`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserBadges` ADD CONSTRAINT `UserBadges_badgeID_fkey` FOREIGN KEY (`badgeID`) REFERENCES `Badge`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Activity` ADD CONSTRAINT `Activity_userID_fkey` FOREIGN KEY (`userID`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Follow` ADD CONSTRAINT `Follow_followedID_fkey` FOREIGN KEY (`followedID`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Follow` ADD CONSTRAINT `Follow_followeeID_fkey` FOREIGN KEY (`followeeID`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notification` ADD CONSTRAINT `Notification_userID_fkey` FOREIGN KEY (`userID`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notification` ADD CONSTRAINT `Notification_activityID_fkey` FOREIGN KEY (`activityID`) REFERENCES `Activity`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Report` ADD CONSTRAINT `Report_submitterID_fkey` FOREIGN KEY (`submitterID`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Report` ADD CONSTRAINT `Report_resolverID_fkey` FOREIGN KEY (`resolverID`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserAuth` ADD CONSTRAINT `UserAuth_userID_fkey` FOREIGN KEY (`userID`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Map` ADD CONSTRAINT `Map_submitterID_fkey` FOREIGN KEY (`submitterID`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Map` ADD CONSTRAINT `Map_thumbnailID_fkey` FOREIGN KEY (`thumbnailID`) REFERENCES `MapImage`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapCredit` ADD CONSTRAINT `MapCredit_userID_fkey` FOREIGN KEY (`userID`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapCredit` ADD CONSTRAINT `MapCredit_mapID_fkey` FOREIGN KEY (`mapID`) REFERENCES `Map`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapFavorite` ADD CONSTRAINT `MapFavorite_userID_fkey` FOREIGN KEY (`userID`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapFavorite` ADD CONSTRAINT `MapFavorite_mapID_fkey` FOREIGN KEY (`mapID`) REFERENCES `Map`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapImage` ADD CONSTRAINT `MapImage_mapID_fkey` FOREIGN KEY (`mapID`) REFERENCES `Map`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapInfo` ADD CONSTRAINT `MapInfo_mapID_fkey` FOREIGN KEY (`mapID`) REFERENCES `Map`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapLibraryEntry` ADD CONSTRAINT `MapLibraryEntry_userID_fkey` FOREIGN KEY (`userID`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapLibraryEntry` ADD CONSTRAINT `MapLibraryEntry_mapID_fkey` FOREIGN KEY (`mapID`) REFERENCES `Map`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapNotify` ADD CONSTRAINT `MapNotify_userID_fkey` FOREIGN KEY (`userID`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapNotify` ADD CONSTRAINT `MapNotify_mapID_fkey` FOREIGN KEY (`mapID`) REFERENCES `Map`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserMapRank` ADD CONSTRAINT `UserMapRank_userID_fkey` FOREIGN KEY (`userID`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserMapRank` ADD CONSTRAINT `UserMapRank_mapID_fkey` FOREIGN KEY (`mapID`) REFERENCES `Map`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserMapRank` ADD CONSTRAINT `UserMapRank_runID_fkey` FOREIGN KEY (`runID`) REFERENCES `Run`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapReview` ADD CONSTRAINT `MapReview_reviewerID_fkey` FOREIGN KEY (`reviewerID`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapReview` ADD CONSTRAINT `MapReview_mapID_fkey` FOREIGN KEY (`mapID`) REFERENCES `Map`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapTrack` ADD CONSTRAINT `MapTrack_mapID_fkey` FOREIGN KEY (`mapID`) REFERENCES `Map`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapTrackStats` ADD CONSTRAINT `MapTrackStats_mapTrackID_fkey` FOREIGN KEY (`mapTrackID`) REFERENCES `MapTrack`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapTrackStats` ADD CONSTRAINT `MapTrackStats_baseStatsID_fkey` FOREIGN KEY (`baseStatsID`) REFERENCES `BaseStats`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapZone` ADD CONSTRAINT `MapZone_trackID_fkey` FOREIGN KEY (`trackID`) REFERENCES `MapTrack`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapZoneTrigger` ADD CONSTRAINT `MapZoneTrigger_mapZoneID_fkey` FOREIGN KEY (`mapZoneID`) REFERENCES `MapZone`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapZoneTriggerProperties` ADD CONSTRAINT `MapZoneTriggerProperties_triggerID_fkey` FOREIGN KEY (`triggerID`) REFERENCES `MapZoneTrigger`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapZoneStats` ADD CONSTRAINT `MapZoneStats_zoneID_fkey` FOREIGN KEY (`zoneID`) REFERENCES `MapZone`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapZoneStats` ADD CONSTRAINT `MapZoneStats_baseStatsID_fkey` FOREIGN KEY (`baseStatsID`) REFERENCES `BaseStats`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapStats` ADD CONSTRAINT `MapStats_mapID_fkey` FOREIGN KEY (`mapID`) REFERENCES `Map`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MapStats` ADD CONSTRAINT `MapStats_baseStatsID_fkey` FOREIGN KEY (`baseStatsID`) REFERENCES `BaseStats`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Run` ADD CONSTRAINT `run_user_fk` FOREIGN KEY (`playerID`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Run` ADD CONSTRAINT `Run_mapID_fkey` FOREIGN KEY (`mapID`) REFERENCES `Map`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Run` ADD CONSTRAINT `Run_baseStatsID_fkey` FOREIGN KEY (`baseStatsID`) REFERENCES `BaseStats`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RunZoneStats` ADD CONSTRAINT `RunZoneStats_baseStatsID_fkey` FOREIGN KEY (`baseStatsID`) REFERENCES `BaseStats`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RunZoneStats` ADD CONSTRAINT `RunZoneStats_runID_fkey` FOREIGN KEY (`runID`) REFERENCES `Run`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RunSession` ADD CONSTRAINT `RunSession_userID_fkey` FOREIGN KEY (`userID`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RunSession` ADD CONSTRAINT `RunSession_trackID_fkey` FOREIGN KEY (`trackID`) REFERENCES `MapTrack`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `RunSessionTimestamp` ADD CONSTRAINT `RunSessionTimestamp_sessionID_fkey` FOREIGN KEY (`sessionID`) REFERENCES `RunSession`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
