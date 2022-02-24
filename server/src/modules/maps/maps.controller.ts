import { Body, Controller, Get, Param, Post, Query, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiBody, ApiOperation, ApiQuery, ApiTags } from '@nestjs/swagger';
import { PagedResponseDto } from '../../@common/dto/common/api-response.dto';
import { MapsService } from './maps.service';
import { JwtAuthGuard } from '../auth/jwt/jwt-auth.guard';
import { MapDto } from '../../@common/dto/map/map.dto';
import { CreateMapDto } from '../../@common/dto/map/createMap.dto';

@ApiBearerAuth()
@Controller('api/v1/maps')
@ApiTags('Maps')
@UseGuards(JwtAuthGuard)
export class MapsController {
    constructor(private readonly mapsService: MapsService) {}

    @Get()
    @ApiOperation({ summary: 'Returns all maps' })
    @ApiQuery({
        name: 'skip',
        type: Number,
        description: 'Offset this many records',
        required: false,
    })
    @ApiQuery({
        name: 'take',
        type: Number,
        description: 'Take this many records',
        required: false,
    })
    public async GetAllMaps(
        @Query('skip') skip?: number,
        @Query('take') take?: number
    ): Promise<PagedResponseDto<MapDto[]>> {
        return this.mapsService.GetAll(skip, take);
    }

    @Get(':mapID')
    @ApiOperation({ summary: 'Returns a single map' })
    @ApiQuery({
        name: 'mapID',
        type: Number,
        description: 'Target Map ID',
        required: true,
    })
    public async GetMap(@Param('mapID') mapID: number): Promise<MapDto> {
        return this.mapsService.Get(mapID);
    }

    @Post()
    @ApiOperation({ summary: 'Creates a single map' })
    @ApiBody({
        type: CreateMapDto,
        description: 'Create map data transfer object',
        required: true,
    })
    public async CreateMap(@Body() mapCreateObj: CreateMapDto): Promise<MapDto> {
        return this.mapsService.Insert(mapCreateObj);
    }
}
