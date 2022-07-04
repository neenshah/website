import { Module } from '@nestjs/common';
import { ReportsController } from './reports.controller';
import { ReportsService } from './reports.service';
import { RepoModule } from '../repo/repo.module';
import { UsersRepoService } from '../repo/users-repo.service';
import { ReportRepoService } from '../repo/reports-repo.service';
import { APP_GUARD } from '@nestjs/core';
import { RolesGuard } from '../auth/guard/roles.guard';

@Module({
    imports: [RepoModule],
    controllers: [ReportsController],
    providers: [{ provide: APP_GUARD, useClass: RolesGuard }, ReportsService, ReportRepoService],
    exports: [ReportsService]
})
export class ReportsModule {}
