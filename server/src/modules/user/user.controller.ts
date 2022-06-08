import {
    Body,
    Controller,
    Delete,
    Get,
    HttpCode,
    HttpStatus,
    Param,
    ParseIntPipe,
    Patch,
    Query,
    UseGuards
} from '@nestjs/common';
import { ApiBearerAuth, ApiBody, ApiOperation, ApiParam, ApiTags } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/jwt/jwt-auth.guard';
import { UpdateUserDto, UserDto } from '../../@common/dto/user/user.dto';
import { UsersService } from '../users/users.service';
import { LoggedInUser } from '../../@common/decorators/logged-in-user.decorator';
import { UserGetQuery } from './queries/get.query.dto';

@ApiBearerAuth()
@Controller('api/v1/user')
@ApiTags('User')
@UseGuards(JwtAuthGuard)
export class UserController {
    constructor(private readonly usersService: UsersService) {}

    @Get()
    @ApiOperation({ summary: 'Get local user, based on JWT' })
    public async GetUser(@LoggedInUser('id') userID: number, @Query() query?: UserGetQuery): Promise<UserDto> {
        return this.usersService.Get(userID, query.expand);
    }

    @Patch()
    @HttpCode(HttpStatus.NO_CONTENT)
    @ApiOperation({ summary: "Update the local users's data" })
    @ApiBody({
        type: UpdateUserDto,
        description: 'Update user data transfer object',
        required: true
    })
    public async Update(@LoggedInUser('id') userID: number, @Body() userUpdateDto: UpdateUserDto) {
        await this.usersService.Update(userID, userUpdateDto);
    }

    // TODO: idk whats going on here but needs work
    @Delete()
    @ApiOperation({ summary: 'Delete the local user and log out' })
    public async Delete(@LoggedInUser('id') userID: number) {
        await this.usersService.Delete(userID);
    }
}
